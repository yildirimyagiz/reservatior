import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ExpenseService {
  final DioClient _dioClient;
  ExpenseService(this._dioClient);

  Future<Expense> getExpenseById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.expenses}/$id');
    return Expense.fromJson(response.data['data']);
  }

  Future<List<Expense>> getExpenses({
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
    final response = await _dioClient.get(ApiEndpoints.expenses, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Expense.fromJson(json)).toList();
  }

  Future<Expense> createExpense(Expense item) async {
    final response = await _dioClient.post(ApiEndpoints.expenses, data: item.toJson());
    return Expense.fromJson(response.data['data']);
  }

  Future<Expense> updateExpense(String id, Expense item) async {
    final response = await _dioClient.patch('${ApiEndpoints.expenses}/$id', data: item.toJson());
    return Expense.fromJson(response.data['data']);
  }

  Future<void> deleteExpense(String id) async {
    await _dioClient.delete('${ApiEndpoints.expenses}/$id');
  }
}
