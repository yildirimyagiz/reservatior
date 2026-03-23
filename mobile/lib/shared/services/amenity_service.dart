import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AmenityService {
  final DioClient _dioClient;

  AmenityService(this._dioClient);

  // Get Amenity by ID
  Future<Amenity> getAmenityById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/amenity/$id');
      return Amenity.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all amenitys
  Future<List<Amenity>> getAmenitys({
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

      final response = await _dioClient.get('/api/v1/amenity', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Amenity.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Amenity
  Future<Amenity> createAmenity(Amenity amenity) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/amenity',
        data: amenity.toJson(),
      );
      return Amenity.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Amenity
  Future<Amenity> updateAmenity(String id, Amenity amenity) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/amenity/$id',
        data: amenity.toJson(),
      );
      return Amenity.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Amenity
  Future<void> deleteAmenity(String id) async {
    try {
      await _dioClient.delete('/api/v1/amenity/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
