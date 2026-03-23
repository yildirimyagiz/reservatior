import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PlanService {
  final DioClient _dioClient;

  PlanService(this._dioClient);

  // Get Plan by ID
  Future<Plan> getPlanById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/plan/$id');
      return Plan.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all plans
  Future<List<Plan>> getPlans({
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

      final response = await _dioClient.get('/api/v1/plan', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Plan.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Plan
  Future<Plan> createPlan(Plan plan) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/plan',
        data: plan.toJson(),
      );
      return Plan.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Plan
  Future<Plan> updatePlan(String id, Plan plan) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/plan/$id',
        data: plan.toJson(),
      );
      return Plan.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Plan
  Future<void> deletePlan(String id) async {
    try {
      await _dioClient.delete('/api/v1/plan/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
