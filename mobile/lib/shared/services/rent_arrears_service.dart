import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class RentArrearsService {
  final DioClient _dioClient;
  RentArrearsService(this._dioClient);

  Future<RentArrears> getRentArrearsById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.rentArrears}/$id');
    return RentArrears.fromJson(response.data['data']);
  }

  Future<List<RentArrears>> getRentArrearses({
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
    final response = await _dioClient.get(ApiEndpoints.rentArrears, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => RentArrears.fromJson(json)).toList();
  }

  Future<RentArrears> createRentArrears(RentArrears item) async {
    final response = await _dioClient.post(ApiEndpoints.rentArrears, data: item.toJson());
    return RentArrears.fromJson(response.data['data']);
  }

  Future<RentArrears> updateRentArrears(String id, RentArrears item) async {
    final response = await _dioClient.patch('${ApiEndpoints.rentArrears}/$id', data: item.toJson());
    return RentArrears.fromJson(response.data['data']);
  }

  Future<void> deleteRentArrears(String id) async {
    await _dioClient.delete('${ApiEndpoints.rentArrears}/$id');
  }
}
