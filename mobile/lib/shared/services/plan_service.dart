import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PlanService {
  final DioClient _dioClient;
  PlanService(this._dioClient);

  Future<Plan> getPlanById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.plans}/$id');
    return Plan.fromJson(response.data['data']);
  }

  Future<List<Plan>> getPlans({
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
    final response = await _dioClient.get(ApiEndpoints.plans, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Plan.fromJson(json)).toList();
  }

  Future<Plan> createPlan(Plan item) async {
    final response = await _dioClient.post(ApiEndpoints.plans, data: item.toJson());
    return Plan.fromJson(response.data['data']);
  }

  Future<Plan> updatePlan(String id, Plan item) async {
    final response = await _dioClient.patch('${ApiEndpoints.plans}/$id', data: item.toJson());
    return Plan.fromJson(response.data['data']);
  }

  Future<void> deletePlan(String id) async {
    await _dioClient.delete('${ApiEndpoints.plans}/$id');
  }
}
