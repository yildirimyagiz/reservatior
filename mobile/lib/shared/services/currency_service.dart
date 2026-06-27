import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class CurrencyService {
  final DioClient _dioClient;
  CurrencyService(this._dioClient);

  Future<Currency> getCurrencyById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.currencies}/$id');
    return Currency.fromJson(response.data['data']);
  }

  Future<List<Currency>> getCurrencies({
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
    final response = await _dioClient.get(ApiEndpoints.currencies, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Currency.fromJson(json)).toList();
  }

  Future<Currency> createCurrency(Currency item) async {
    final response = await _dioClient.post(ApiEndpoints.currencies, data: item.toJson());
    return Currency.fromJson(response.data['data']);
  }

  Future<Currency> updateCurrency(String id, Currency item) async {
    final response = await _dioClient.patch('${ApiEndpoints.currencies}/$id', data: item.toJson());
    return Currency.fromJson(response.data['data']);
  }

  Future<void> deleteCurrency(String id) async {
    await _dioClient.delete('${ApiEndpoints.currencies}/$id');
  }
}
