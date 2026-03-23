import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class OrganizationService {
  final DioClient _dioClient;

  OrganizationService(this._dioClient);

  // Get Organization by ID
  Future<Organization> getOrganizationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/organization/$id');
      return Organization.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all organizations
  Future<List<Organization>> getOrganizations({
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

      final response = await _dioClient.get('/api/v1/organization', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Organization.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Organization
  Future<Organization> createOrganization(Organization organization) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/organization',
        data: organization.toJson(),
      );
      return Organization.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Organization
  Future<Organization> updateOrganization(String id, Organization organization) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/organization/$id',
        data: organization.toJson(),
      );
      return Organization.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Organization
  Future<void> deleteOrganization(String id) async {
    try {
      await _dioClient.delete('/api/v1/organization/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
