import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class SolicitorManagementService {
  final DioClient _dioClient;

  SolicitorManagementService(this._dioClient);

  // Get SolicitorManagement by ID
  Future<SolicitorManagement> getSolicitorManagementById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/solicitor_management/$id');
      return SolicitorManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all solicitor_managements
  Future<List<SolicitorManagement>> getSolicitorManagements({
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

      final response = await _dioClient.get('/api/v1/solicitor_management', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => SolicitorManagement.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create SolicitorManagement
  Future<SolicitorManagement> createSolicitorManagement(SolicitorManagement solicitorManagement) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/solicitor_management',
        data: solicitorManagement.toJson(),
      );
      return SolicitorManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update SolicitorManagement
  Future<SolicitorManagement> updateSolicitorManagement(String id, SolicitorManagement solicitorManagement) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/solicitor_management/$id',
        data: solicitorManagement.toJson(),
      );
      return SolicitorManagement.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete SolicitorManagement
  Future<void> deleteSolicitorManagement(String id) async {
    try {
      await _dioClient.delete('/api/v1/solicitor_management/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
