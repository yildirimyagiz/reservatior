import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class DealService {
  final DioClient _dioClient;
  DealService(this._dioClient);

  Future<Deal> getDealById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.deals}/$id');
    return Deal.fromJson(response.data['data']);
  }

  Future<List<Deal>> getDeals({
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
    final response = await _dioClient.get(ApiEndpoints.deals, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Deal.fromJson(json)).toList();
  }

  Future<Deal> createDeal(Deal item) async {
    final response = await _dioClient.post(ApiEndpoints.deals, data: item.toJson());
    return Deal.fromJson(response.data['data']);
  }

  Future<Deal> updateDeal(String id, Deal item) async {
    final response = await _dioClient.patch('${ApiEndpoints.deals}/$id', data: item.toJson());
    return Deal.fromJson(response.data['data']);
  }

  Future<void> deleteDeal(String id) async {
    await _dioClient.delete('${ApiEndpoints.deals}/$id');
  }
}
