import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PropertyInventoryService {
  final DioClient _dioClient;

  PropertyInventoryService(this._dioClient);

  // Get PropertyInventory by ID
  Future<PropertyInventory> getPropertyInventoryById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_inventory/$id');
      return PropertyInventory.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all property_inventorys
  Future<List<PropertyInventory>> getPropertyInventorys({
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

      final response = await _dioClient.get('/api/v1/property_inventory', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PropertyInventory.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PropertyInventory
  Future<PropertyInventory> createPropertyInventory(PropertyInventory propertyInventory) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_inventory',
        data: propertyInventory.toJson(),
      );
      return PropertyInventory.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyInventory
  Future<PropertyInventory> updatePropertyInventory(String id, PropertyInventory propertyInventory) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_inventory/$id',
        data: propertyInventory.toJson(),
      );
      return PropertyInventory.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyInventory
  Future<void> deletePropertyInventory(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_inventory/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
