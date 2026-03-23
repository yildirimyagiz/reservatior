import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class RightToRentCheckService {
  final DioClient _dioClient;

  RightToRentCheckService(this._dioClient);

  // Get RightToRentCheck by ID
  Future<RightToRentCheck> getRightToRentCheckById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/right_to_rent_check/$id');
      return RightToRentCheck.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all right_to_rent_checks
  Future<List<RightToRentCheck>> getRightToRentChecks({
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

      final response = await _dioClient.get('/api/v1/right_to_rent_check', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => RightToRentCheck.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create RightToRentCheck
  Future<RightToRentCheck> createRightToRentCheck(RightToRentCheck rightToRentCheck) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/right_to_rent_check',
        data: rightToRentCheck.toJson(),
      );
      return RightToRentCheck.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update RightToRentCheck
  Future<RightToRentCheck> updateRightToRentCheck(String id, RightToRentCheck rightToRentCheck) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/right_to_rent_check/$id',
        data: rightToRentCheck.toJson(),
      );
      return RightToRentCheck.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete RightToRentCheck
  Future<void> deleteRightToRentCheck(String id) async {
    try {
      await _dioClient.delete('/api/v1/right_to_rent_check/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
