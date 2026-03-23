import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class IncludedServiceService {
  final DioClient _dioClient;

  IncludedServiceService(this._dioClient);

  // Get IncludedService by ID
  Future<IncludedService> getIncludedServiceById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/included_service/$id');
      return IncludedService.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all included_services
  Future<List<IncludedService>> getIncludedServices({
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

      final response = await _dioClient.get('/api/v1/included_service', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => IncludedService.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create IncludedService
  Future<IncludedService> createIncludedService(IncludedService includedService) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/included_service',
        data: includedService.toJson(),
      );
      return IncludedService.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update IncludedService
  Future<IncludedService> updateIncludedService(String id, IncludedService includedService) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/included_service/$id',
        data: includedService.toJson(),
      );
      return IncludedService.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete IncludedService
  Future<void> deleteIncludedService(String id) async {
    try {
      await _dioClient.delete('/api/v1/included_service/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
