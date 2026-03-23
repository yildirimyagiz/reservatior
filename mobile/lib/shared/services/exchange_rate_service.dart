import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ExchangeRateService {
  final DioClient _dioClient;

  ExchangeRateService(this._dioClient);

  // Get ExchangeRate by ID
  Future<ExchangeRate> getExchangeRateById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/exchange_rate/$id');
      return ExchangeRate.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all exchange_rates
  Future<List<ExchangeRate>> getExchangeRates({
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

      final response = await _dioClient.get('/api/v1/exchange_rate', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ExchangeRate.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ExchangeRate
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
    return Exception('API Error: ${e.message}');
  }
}
