import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ExchangeRate operations
/// Provides CRUD operations with proper error handling and type safety
class ExchangeRateRepository {
  final DioClient _dioClient;

  ExchangeRateRepository(this._dioClient);

  /// Get ExchangeRate by ID
  /// Returns [ExchangeRate] if found, throws [RepositoryException] otherwise
  Future<ExchangeRate> getExchangeRateById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/exchange_rate/$id');
      if (response.statusCode == 200) {
        return ExchangeRate.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch exchange_rate',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all exchange_rates with pagination and filtering
  /// Returns list of [ExchangeRate] objects
  Future<List<ExchangeRate>> getexchange_rates({
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
      
      final response = await _dioClient.get('/api/v1/exchange_rate', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ExchangeRate.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch exchange_rates',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ExchangeRate
  /// Returns created [ExchangeRate] object
  Future<ExchangeRate> createExchangeRate(ExchangeRate exchangeRate) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/exchange_rate',
        data: exchangeRate.toJson(),
      );
      return ExchangeRate.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ExchangeRate
  Future<ExchangeRate> updateExchangeRate(String id, ExchangeRate exchangeRate) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/exchange_rate/$id',
        data: exchangeRate.toJson(),
      );
      return ExchangeRate.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ExchangeRate
  Future<void> deleteExchangeRate(String id) async {
    try {
      await _dioClient.delete('/api/v1/exchange_rate/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
