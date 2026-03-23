import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ExpenseService {
  final DioClient _dioClient;

  ExpenseService(this._dioClient);

  // Get Expense by ID
  Future<Expense> getExpenseById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/expense/$id');
      return Expense.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all expenses
  Future<List<Expense>> getExpenses({
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

      final response = await _dioClient.get('/api/v1/expense', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Expense.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Expense
  Future<Expense> createExpense(Expense expense) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/expense',
        data: expense.toJson(),
      );
      return Expense.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Expense
  Future<Expense> updateExpense(String id, Expense expense) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/expense/$id',
        data: expense.toJson(),
      );
      return Expense.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Expense
  Future<void> deleteExpense(String id) async {
    try {
      await _dioClient.delete('/api/v1/expense/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
