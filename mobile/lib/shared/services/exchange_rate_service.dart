import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ExchangeRateService {
  final DioClient _dioClient;
  ExchangeRateService(this._dioClient);

  Future<ExchangeRate> getExchangeRateById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.exchangeRates}/$id');
    return ExchangeRate.fromJson(response.data['data']);
  }

  Future<List<ExchangeRate>> getExchangeRates({
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
    final response = await _dioClient.get(ApiEndpoints.exchangeRates, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ExchangeRate.fromJson(json)).toList();
  }

  Future<ExchangeRate> createExchangeRate(ExchangeRate item) async {
    final response = await _dioClient.post(ApiEndpoints.exchangeRates, data: item.toJson());
    return ExchangeRate.fromJson(response.data['data']);
  }

  Future<ExchangeRate> updateExchangeRate(String id, ExchangeRate item) async {
    final response = await _dioClient.patch('${ApiEndpoints.exchangeRates}/$id', data: item.toJson());
    return ExchangeRate.fromJson(response.data['data']);
  }

  Future<void> deleteExchangeRate(String id) async {
    await _dioClient.delete('${ApiEndpoints.exchangeRates}/$id');
  }

  Future<ExchangeRate> getLatest(String base, String target) async {
    final response = await _dioClient.get('${ApiEndpoints.exchangeRates}/latest', queryParameters: {'base': base, 'target': target});
    return ExchangeRate.fromJson(response.data['data']);
  }

  Future<Map<String, dynamic>> convert(String from, String to, double amount, {String? date}) async {
    final response = await _dioClient.get(
      '${ApiEndpoints.exchangeRates}/convert', 
      queryParameters: {
        'from': from, 
        'to': to, 
        'amount': amount,
        if (date != null) 'date': date,
      }
    );
    return response.data['data'];
  }
}
