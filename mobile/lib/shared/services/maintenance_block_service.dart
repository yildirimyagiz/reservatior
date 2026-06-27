import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MaintenanceBlockService {
  final DioClient _dioClient;
  MaintenanceBlockService(this._dioClient);

  Future<MaintenanceBlock> getMaintenanceBlockById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.maintenanceBlocks}/$id');
    return MaintenanceBlock.fromJson(response.data['data']);
  }

  Future<List<MaintenanceBlock>> getMaintenanceBlocks({
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
    final response = await _dioClient.get(ApiEndpoints.maintenanceBlocks, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => MaintenanceBlock.fromJson(json)).toList();
  }

  Future<MaintenanceBlock> createMaintenanceBlock(MaintenanceBlock item) async {
    final response = await _dioClient.post(ApiEndpoints.maintenanceBlocks, data: item.toJson());
    return MaintenanceBlock.fromJson(response.data['data']);
  }

  Future<MaintenanceBlock> updateMaintenanceBlock(String id, MaintenanceBlock item) async {
    final response = await _dioClient.patch('${ApiEndpoints.maintenanceBlocks}/$id', data: item.toJson());
    return MaintenanceBlock.fromJson(response.data['data']);
  }

  Future<void> deleteMaintenanceBlock(String id) async {
    await _dioClient.delete('${ApiEndpoints.maintenanceBlocks}/$id');
  }
}
