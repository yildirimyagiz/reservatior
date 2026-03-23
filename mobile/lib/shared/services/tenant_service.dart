import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class TenantService {
  final DioClient _dioClient;

  TenantService(this._dioClient);

  // Get Tenant by ID
  Future<Tenant> getTenantById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/tenant/$id');
      return Tenant.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all tenants
  Future<List<Tenant>> getTenants({
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

      final response = await _dioClient.get('/api/v1/tenant', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Tenant.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Tenant
  Future<Tenant> createTenant(Tenant tenant) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/tenant',
        data: tenant.toJson(),
      );
      return Tenant.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Tenant
  Future<Tenant> updateTenant(String id, Tenant tenant) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/tenant/$id',
        data: tenant.toJson(),
      );
      return Tenant.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Tenant
  Future<void> deleteTenant(String id) async {
    try {
      await _dioClient.delete('/api/v1/tenant/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
