import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Budget operations
/// Provides CRUD operations with proper error handling and type safety
class BudgetRepository {
  final DioClient _dioClient;

  BudgetRepository(this._dioClient);

  /// Get Budget by ID
  /// Returns [Budget] if found, throws [RepositoryException] otherwise
  Future<Budget> getBudgetById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/budget/$id');
      if (response.statusCode == 200) {
        return Budget.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch budget',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all budgets with pagination and filtering
  /// Returns list of [Budget] objects
  Future<List<Budget>> getbudgets({
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
      
      final response = await _dioClient.get('/api/v1/budget', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Budget.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch budgets',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Budget
  /// Returns created [Budget] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
