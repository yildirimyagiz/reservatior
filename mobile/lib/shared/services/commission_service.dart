import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class CommissionService {
  final DioClient _dioClient;
  CommissionService(this._dioClient);

  Future<Commission> getCommissionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.commissions}/$id');
    return Commission.fromJson(response.data['data']);
  }

  Future<List<Commission>> getCommissions({
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
    final response = await _dioClient.get(ApiEndpoints.commissions, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Commission.fromJson(json)).toList();
  }

  Future<Commission> createCommission(Commission item) async {
    final response = await _dioClient.post(ApiEndpoints.commissions, data: item.toJson());
    return Commission.fromJson(response.data['data']);
  }

  Future<Commission> updateCommission(String id, Commission item) async {
    final response = await _dioClient.patch('${ApiEndpoints.commissions}/$id', data: item.toJson());
    return Commission.fromJson(response.data['data']);
  }

  Future<void> deleteCommission(String id) async {
    await _dioClient.delete('${ApiEndpoints.commissions}/$id');
  }
}
