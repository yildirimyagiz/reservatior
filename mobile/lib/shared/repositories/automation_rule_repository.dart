import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AutomationRule operations
/// Provides CRUD operations with proper error handling and type safety
class AutomationRuleRepository {
  final DioClient _dioClient;

  AutomationRuleRepository(this._dioClient);

  /// Get AutomationRule by ID
  /// Returns [AutomationRule] if found, throws [RepositoryException] otherwise
  Future<AutomationRule> getAutomationRuleById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/automation_rule/$id');
      if (response.statusCode == 200) {
        return AutomationRule.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch automation_rule',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all automation_rules with pagination and filtering
  /// Returns list of [AutomationRule] objects
  Future<List<AutomationRule>> getautomation_rules({
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
      
      final response = await _dioClient.get('/api/v1/automation_rule', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AutomationRule.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch automation_rules',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AutomationRule
  /// Returns created [AutomationRule] object
  Future<AutomationRule> createAutomationRule(AutomationRule automationRule) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/automation_rule',
        data: automationRule.toJson(),
      );
      return AutomationRule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AutomationRule
  Future<AutomationRule> updateAutomationRule(String id, AutomationRule automationRule) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/automation_rule/$id',
        data: automationRule.toJson(),
      );
      return AutomationRule.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AutomationRule
  Future<void> deleteAutomationRule(String id) async {
    try {
      await _dioClient.delete('/api/v1/automation_rule/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
