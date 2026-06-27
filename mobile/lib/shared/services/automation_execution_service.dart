import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AutomationExecutionService {
  final DioClient _dioClient;
  AutomationExecutionService(this._dioClient);

  Future<AutomationExecution> getAutomationExecutionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.automationExecutions}/$id');
    return AutomationExecution.fromJson(response.data['data']);
  }

  Future<List<AutomationExecution>> getAutomationExecutions({
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
    final response = await _dioClient.get(ApiEndpoints.automationExecutions, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AutomationExecution.fromJson(json)).toList();
  }

  Future<AutomationExecution> createAutomationExecution(AutomationExecution item) async {
    final response = await _dioClient.post(ApiEndpoints.automationExecutions, data: item.toJson());
    return AutomationExecution.fromJson(response.data['data']);
  }

  Future<AutomationExecution> updateAutomationExecution(String id, AutomationExecution item) async {
    final response = await _dioClient.patch('${ApiEndpoints.automationExecutions}/$id', data: item.toJson());
    return AutomationExecution.fromJson(response.data['data']);
  }

  Future<void> deleteAutomationExecution(String id) async {
    await _dioClient.delete('${ApiEndpoints.automationExecutions}/$id');
  }
}
