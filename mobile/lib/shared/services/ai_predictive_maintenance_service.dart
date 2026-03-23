import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIPredictiveMaintenanceService {
  final DioClient _dioClient;

  AIPredictiveMaintenanceService(this._dioClient);

  // Get AIPredictiveMaintenance by ID
  Future<AIPredictiveMaintenance> getAIPredictiveMaintenanceById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_predictive_maintenance/$id');
      return AIPredictiveMaintenance.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_predictive_maintenances
  Future<List<AIPredictiveMaintenance>> getAIPredictiveMaintenances({
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

      final response = await _dioClient.get('/api/v1/ai_predictive_maintenance', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIPredictiveMaintenance.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIPredictiveMaintenance
  Future<AIPredictiveMaintenance> createAIPredictiveMaintenance(AIPredictiveMaintenance aIPredictiveMaintenance) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_predictive_maintenance',
        data: aIPredictiveMaintenance.toJson(),
      );
      return AIPredictiveMaintenance.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIPredictiveMaintenance
  Future<AIPredictiveMaintenance> updateAIPredictiveMaintenance(String id, AIPredictiveMaintenance aIPredictiveMaintenance) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_predictive_maintenance/$id',
        data: aIPredictiveMaintenance.toJson(),
      );
      return AIPredictiveMaintenance.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIPredictiveMaintenance
  Future<void> deleteAIPredictiveMaintenance(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_predictive_maintenance/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
