import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class BudgetService {
  final DioClient _dioClient;
  BudgetService(this._dioClient);

  Future<Budget> getBudgetById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.budgets}/$id');
    return Budget.fromJson(response.data['data']);
  }

  Future<List<Budget>> getBudgets({
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
    final response = await _dioClient.get(ApiEndpoints.budgets, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Budget.fromJson(json)).toList();
  }

  Future<Budget> createBudget(Budget item) async {
    final response = await _dioClient.post(ApiEndpoints.budgets, data: item.toJson());
    return Budget.fromJson(response.data['data']);
  }

  Future<Budget> updateBudget(String id, Budget item) async {
    final response = await _dioClient.patch('${ApiEndpoints.budgets}/$id', data: item.toJson());
    return Budget.fromJson(response.data['data']);
  }

  Future<void> deleteBudget(String id) async {
    await _dioClient.delete('${ApiEndpoints.budgets}/$id');
  }
}
