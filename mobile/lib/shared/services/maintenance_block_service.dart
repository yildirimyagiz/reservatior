import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MaintenanceBlockService {
  final DioClient _dioClient;

  MaintenanceBlockService(this._dioClient);

  // Get MaintenanceBlock by ID
  Future<MaintenanceBlock> getMaintenanceBlockById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/maintenance_block/$id');
      return MaintenanceBlock.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all maintenance_blocks
  Future<List<MaintenanceBlock>> getMaintenanceBlocks({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/maintenance_block', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MaintenanceBlock.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MaintenanceBlock
  Future<MaintenanceBlock> createMaintenanceBlock(MaintenanceBlock maintenanceBlock) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/maintenance_block',
        data: maintenanceBlock.toJson(),
      );
      return MaintenanceBlock.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MaintenanceBlock
  Future<MaintenanceBlock> updateMaintenanceBlock(String id, MaintenanceBlock maintenanceBlock) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/maintenance_block/$id',
        data: maintenanceBlock.toJson(),
      );
      return MaintenanceBlock.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MaintenanceBlock
  Future<void> deleteMaintenanceBlock(String id) async {
    try {
      await _dioClient.delete('/api/v1/maintenance_block/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
