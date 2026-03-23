import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AttorneyManagementService {
  final DioClient _dioClient;

  AttorneyManagementService(this._dioClient);

  // Get AttorneyManagement by ID
  Future<AttorneyManagement> getAttorneyManagementById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/attorney_management/$id');
      return AttorneyManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all attorney_managements
  Future<List<AttorneyManagement>> getAttorneyManagements({
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

      final response = await _dioClient.get('/api/v1/attorney_management', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AttorneyManagement.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AttorneyManagement
  Future<AttorneyManagement> createAttorneyManagement(AttorneyManagement attorneyManagement) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/attorney_management',
        data: attorneyManagement.toJson(),
      );
      return AttorneyManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AttorneyManagement
  Future<AttorneyManagement> updateAttorneyManagement(String id, AttorneyManagement attorneyManagement) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/attorney_management/$id',
        data: attorneyManagement.toJson(),
      );
      return AttorneyManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AttorneyManagement
  Future<void> deleteAttorneyManagement(String id) async {
    try {
      await _dioClient.delete('/api/v1/attorney_management/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
