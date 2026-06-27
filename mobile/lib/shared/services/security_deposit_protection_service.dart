import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class SecurityDepositProtectionService {
  final DioClient _dioClient;
  SecurityDepositProtectionService(this._dioClient);

  Future<SecurityDepositProtection> getSecurityDepositProtectionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.securityDepositProtections}/$id');
    return SecurityDepositProtection.fromJson(response.data['data']);
  }

  Future<List<SecurityDepositProtection>> getSecurityDepositProtections({
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
    final response = await _dioClient.get(ApiEndpoints.securityDepositProtections, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => SecurityDepositProtection.fromJson(json)).toList();
  }

  Future<SecurityDepositProtection> createSecurityDepositProtection(SecurityDepositProtection item) async {
    final response = await _dioClient.post(ApiEndpoints.securityDepositProtections, data: item.toJson());
    return SecurityDepositProtection.fromJson(response.data['data']);
  }

  Future<SecurityDepositProtection> updateSecurityDepositProtection(String id, SecurityDepositProtection item) async {
    final response = await _dioClient.patch('${ApiEndpoints.securityDepositProtections}/$id', data: item.toJson());
    return SecurityDepositProtection.fromJson(response.data['data']);
  }

  Future<void> deleteSecurityDepositProtection(String id) async {
    await _dioClient.delete('${ApiEndpoints.securityDepositProtections}/$id');
  }
}
