import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class FloorPlanService {
  final DioClient _dioClient;

  FloorPlanService(this._dioClient);

  // Get FloorPlan by ID
  Future<FloorPlan> getFloorPlanById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/floor_plan/$id');
      return FloorPlan.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all floor_plans
  Future<List<FloorPlan>> getFloorPlans({
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

      final response = await _dioClient.get('/api/v1/floor_plan', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => FloorPlan.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create FloorPlan
  Future<FloorPlan> createFloorPlan(FloorPlan floorPlan) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/floor_plan',
        data: floorPlan.toJson(),
      );
      return FloorPlan.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update FloorPlan
  Future<FloorPlan> updateFloorPlan(String id, FloorPlan floorPlan) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/floor_plan/$id',
        data: floorPlan.toJson(),
      );
      return FloorPlan.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete FloorPlan
  Future<void> deleteFloorPlan(String id) async {
    try {
      await _dioClient.delete('/api/v1/floor_plan/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
