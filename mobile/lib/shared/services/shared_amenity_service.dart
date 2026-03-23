import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class SharedAmenityService {
  final DioClient _dioClient;

  SharedAmenityService(this._dioClient);

  // Get SharedAmenity by ID
  Future<SharedAmenity> getSharedAmenityById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/shared_amenity/$id');
      return SharedAmenity.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all shared_amenitys
  Future<List<SharedAmenity>> getSharedAmenitys({
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

      final response = await _dioClient.get('/api/v1/shared_amenity', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => SharedAmenity.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create SharedAmenity
  Future<SharedAmenity> createSharedAmenity(SharedAmenity sharedAmenity) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/shared_amenity',
        data: sharedAmenity.toJson(),
      );
      return SharedAmenity.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update SharedAmenity
  Future<SharedAmenity> updateSharedAmenity(String id, SharedAmenity sharedAmenity) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/shared_amenity/$id',
        data: sharedAmenity.toJson(),
      );
      return SharedAmenity.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete SharedAmenity
  Future<void> deleteSharedAmenity(String id) async {
    try {
      await _dioClient.delete('/api/v1/shared_amenity/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
