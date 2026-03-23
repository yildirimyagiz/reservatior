import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class CurrencyService {
  final DioClient _dioClient;

  CurrencyService(this._dioClient);

  // Get Currency by ID
  Future<Currency> getCurrencyById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/currency/$id');
      return Currency.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all currencys
  Future<List<Currency>> getCurrencys({
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

      final response = await _dioClient.get('/api/v1/currency', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Currency.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Currency
  Future<Currency> createCurrency(Currency currency) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/currency',
        data: currency.toJson(),
      );
      return Currency.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Currency
  Future<Currency> updateCurrency(String id, Currency currency) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/currency/$id',
        data: currency.toJson(),
      );
      return Currency.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Currency
  Future<void> deleteCurrency(String id) async {
    try {
      await _dioClient.delete('/api/v1/currency/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
