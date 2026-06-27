import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiPredictiveMaintenanceService {
  final DioClient _dioClient;
  AiPredictiveMaintenanceService(this._dioClient);

  Future<AiPredictiveMaintenance> getAiPredictiveMaintenanceById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiPredictiveMaintenances}/$id');
    return AiPredictiveMaintenance.fromJson(response.data['data']);
  }

  Future<List<AiPredictiveMaintenance>> getAiPredictiveMaintenances({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.aiPredictiveMaintenances, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiPredictiveMaintenance.fromJson(json)).toList();
  }

  Future<AiPredictiveMaintenance> createAiPredictiveMaintenance(AiPredictiveMaintenance item) async {
    final response = await _dioClient.post(ApiEndpoints.aiPredictiveMaintenances, data: item.toJson());
    return AiPredictiveMaintenance.fromJson(response.data['data']);
  }

  Future<AiPredictiveMaintenance> updateAiPredictiveMaintenance(String id, AiPredictiveMaintenance item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiPredictiveMaintenances}/$id', data: item.toJson());
    return AiPredictiveMaintenance.fromJson(response.data['data']);
  }

  Future<void> deleteAiPredictiveMaintenance(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiPredictiveMaintenances}/$id');
  }
}
