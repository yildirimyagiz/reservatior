import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MobileDeviceService {
  final DioClient _dioClient;
  MobileDeviceService(this._dioClient);

  Future<MobileDevice> getMobileDeviceById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.mobileDevices}/$id');
    return MobileDevice.fromJson(response.data['data']);
  }

  Future<List<MobileDevice>> getMobileDevices({
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
    final response = await _dioClient.get(ApiEndpoints.mobileDevices, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => MobileDevice.fromJson(json)).toList();
  }

  Future<MobileDevice> createMobileDevice(MobileDevice item) async {
    final response = await _dioClient.post(ApiEndpoints.mobileDevices, data: item.toJson());
    return MobileDevice.fromJson(response.data['data']);
  }

  Future<MobileDevice> updateMobileDevice(String id, MobileDevice item) async {
    final response = await _dioClient.patch('${ApiEndpoints.mobileDevices}/$id', data: item.toJson());
    return MobileDevice.fromJson(response.data['data']);
  }

  Future<void> deleteMobileDevice(String id) async {
    await _dioClient.delete('${ApiEndpoints.mobileDevices}/$id');
  }
}
