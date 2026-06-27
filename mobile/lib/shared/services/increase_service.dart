import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class IncreaseService {
  final DioClient _dioClient;
  IncreaseService(this._dioClient);

  Future<Increase> getIncreaseById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.increases}/$id');
    return Increase.fromJson(response.data['data']);
  }

  Future<List<Increase>> getIncreases({
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
    final response = await _dioClient.get(ApiEndpoints.increases, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Increase.fromJson(json)).toList();
  }

  Future<Increase> createIncrease(Increase item) async {
    final response = await _dioClient.post(ApiEndpoints.increases, data: item.toJson());
    return Increase.fromJson(response.data['data']);
  }

  Future<Increase> updateIncrease(String id, Increase item) async {
    final response = await _dioClient.patch('${ApiEndpoints.increases}/$id', data: item.toJson());
    return Increase.fromJson(response.data['data']);
  }

  Future<void> deleteIncrease(String id) async {
    await _dioClient.delete('${ApiEndpoints.increases}/$id');
  }
}
