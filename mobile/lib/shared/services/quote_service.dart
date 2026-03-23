import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class QuoteService {
  final DioClient _dioClient;

  QuoteService(this._dioClient);

  // Get Quote by ID
  Future<Quote> getQuoteById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/quote/$id');
      return Quote.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all quotes
  Future<List<Quote>> getQuotes({
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

      final response = await _dioClient.get('/api/v1/quote', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Quote.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Quote
  Future<Quote> createQuote(Quote quote) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/quote',
        data: quote.toJson(),
      );
      return Quote.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Quote
  Future<Quote> updateQuote(String id, Quote quote) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/quote/$id',
        data: quote.toJson(),
      );
      return Quote.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Quote
  Future<void> deleteQuote(String id) async {
    try {
      await _dioClient.delete('/api/v1/quote/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
