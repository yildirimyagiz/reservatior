import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class DepositProtectionService {
  final DioClient _dioClient;
  DepositProtectionService(this._dioClient);

  Future<DepositProtection> getDepositProtectionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.depositProtections}/$id');
    return DepositProtection.fromJson(response.data['data']);
  }

  Future<List<DepositProtection>> getDepositProtections({
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
    final response = await _dioClient.get(ApiEndpoints.depositProtections, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => DepositProtection.fromJson(json)).toList();
  }

  Future<DepositProtection> createDepositProtection(DepositProtection item) async {
    final response = await _dioClient.post(ApiEndpoints.depositProtections, data: item.toJson());
    return DepositProtection.fromJson(response.data['data']);
  }

  Future<DepositProtection> updateDepositProtection(String id, DepositProtection item) async {
    final response = await _dioClient.patch('${ApiEndpoints.depositProtections}/$id', data: item.toJson());
    return DepositProtection.fromJson(response.data['data']);
  }

  Future<void> deleteDepositProtection(String id) async {
    await _dioClient.delete('${ApiEndpoints.depositProtections}/$id');
  }
}
