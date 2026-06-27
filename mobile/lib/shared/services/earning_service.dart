import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class EarningService {
  final DioClient _dioClient;
  EarningService(this._dioClient);

  Future<Earning> getEarningById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.earnings}/$id');
    return Earning.fromJson(response.data['data']);
  }

  Future<List<Earning>> getEarnings({
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
    final response = await _dioClient.get(ApiEndpoints.earnings, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Earning.fromJson(json)).toList();
  }

  Future<Earning> createEarning(Earning item) async {
    final response = await _dioClient.post(ApiEndpoints.earnings, data: item.toJson());
    return Earning.fromJson(response.data['data']);
  }

  Future<Earning> updateEarning(String id, Earning item) async {
    final response = await _dioClient.patch('${ApiEndpoints.earnings}/$id', data: item.toJson());
    return Earning.fromJson(response.data['data']);
  }

  Future<void> deleteEarning(String id) async {
    await _dioClient.delete('${ApiEndpoints.earnings}/$id');
  }
}
