import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class TenantApplicationService {
  final DioClient _dioClient;

  TenantApplicationService(this._dioClient);

  // Get TenantApplication by ID
  Future<TenantApplication> getTenantApplicationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/tenant_application/$id');
      return TenantApplication.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all tenant_applications
  Future<List<TenantApplication>> getTenantApplications({
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

      final response = await _dioClient.get('/api/v1/tenant_application', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => TenantApplication.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create TenantApplication
  Future<TenantApplication> createTenantApplication(TenantApplication tenantApplication) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/tenant_application',
        data: tenantApplication.toJson(),
      );
      return TenantApplication.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update TenantApplication
  Future<TenantApplication> updateTenantApplication(String id, TenantApplication tenantApplication) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/tenant_application/$id',
        data: tenantApplication.toJson(),
      );
      return TenantApplication.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete TenantApplication
  Future<void> deleteTenantApplication(String id) async {
    try {
      await _dioClient.delete('/api/v1/tenant_application/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
