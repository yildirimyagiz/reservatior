import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class FacilityService {
  final DioClient _dioClient;

  FacilityService(this._dioClient);

  // Get Facility by ID
  Future<Facility> getFacilityById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/facility/$id');
      return Facility.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all facilitys
  Future<List<Facility>> getFacilitys({
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

      final response = await _dioClient.get('/api/v1/facility', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Facility.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Facility
  Future<Facility> createFacility(Facility facility) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/facility',
        data: facility.toJson(),
      );
      return Facility.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Facility
  Future<Facility> updateFacility(String id, Facility facility) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/facility/$id',
        data: facility.toJson(),
      );
      return Facility.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Facility
  Future<void> deleteFacility(String id) async {
    try {
      await _dioClient.delete('/api/v1/facility/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
