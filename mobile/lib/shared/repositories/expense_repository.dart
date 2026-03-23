import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Expense operations
/// Provides CRUD operations with proper error handling and type safety
class ExpenseRepository {
  final DioClient _dioClient;

  ExpenseRepository(this._dioClient);

  /// Get Expense by ID
  /// Returns [Expense] if found, throws [RepositoryException] otherwise
  Future<Expense> getExpenseById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/expense/$id');
      if (response.statusCode == 200) {
        return Expense.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch expense',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all expenses with pagination and filtering
  /// Returns list of [Expense] objects
  Future<List<Expense>> getexpenses({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/expense', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Expense.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch expenses',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Expense
  /// Returns created [Expense] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
