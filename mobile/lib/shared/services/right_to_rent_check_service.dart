import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class RightToRentCheckService {
  final DioClient _dioClient;
  RightToRentCheckService(this._dioClient);

  Future<RightToRentCheck> getRightToRentCheckById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.rightToRentChecks}/$id');
    return RightToRentCheck.fromJson(response.data['data']);
  }

  Future<List<RightToRentCheck>> getRightToRentChecks({
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
    final response = await _dioClient.get(ApiEndpoints.rightToRentChecks, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => RightToRentCheck.fromJson(json)).toList();
  }

  Future<RightToRentCheck> createRightToRentCheck(RightToRentCheck item) async {
    final response = await _dioClient.post(ApiEndpoints.rightToRentChecks, data: item.toJson());
    return RightToRentCheck.fromJson(response.data['data']);
  }

  Future<RightToRentCheck> updateRightToRentCheck(String id, RightToRentCheck item) async {
    final response = await _dioClient.patch('${ApiEndpoints.rightToRentChecks}/$id', data: item.toJson());
    return RightToRentCheck.fromJson(response.data['data']);
  }

  Future<void> deleteRightToRentCheck(String id) async {
    await _dioClient.delete('${ApiEndpoints.rightToRentChecks}/$id');
  }
}
