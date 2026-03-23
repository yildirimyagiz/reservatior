import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class BudgetService {
  final DioClient _dioClient;

  BudgetService(this._dioClient);

  // Get Budget by ID
  Future<Budget> getBudgetById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/budget/$id');
      return Budget.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all budgets
  Future<List<Budget>> getBudgets({
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

      final response = await _dioClient.get('/api/v1/budget', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Budget.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Budget
  Future<Budget> createBudget(Budget budget) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/budget',
        data: budget.toJson(),
      );
      return Budget.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Budget
  Future<Budget> updateBudget(String id, Budget budget) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/budget/$id',
        data: budget.toJson(),
      );
      return Budget.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Budget
  Future<void> deleteBudget(String id) async {
    try {
      await _dioClient.delete('/api/v1/budget/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
