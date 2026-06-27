import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class QuoteService {
  final DioClient _dioClient;
  QuoteService(this._dioClient);

  Future<Quote> getQuoteById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.quotes}/$id');
    return Quote.fromJson(response.data['data']);
  }

  Future<List<Quote>> getQuotes({
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
    final response = await _dioClient.get(ApiEndpoints.quotes, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Quote.fromJson(json)).toList();
  }

  Future<Quote> createQuote(Quote item) async {
    final response = await _dioClient.post(ApiEndpoints.quotes, data: item.toJson());
    return Quote.fromJson(response.data['data']);
  }

  Future<Quote> updateQuote(String id, Quote item) async {
    final response = await _dioClient.patch('${ApiEndpoints.quotes}/$id', data: item.toJson());
    return Quote.fromJson(response.data['data']);
  }

  Future<void> deleteQuote(String id) async {
    await _dioClient.delete('${ApiEndpoints.quotes}/$id');
  }
}
