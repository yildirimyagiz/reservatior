import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class LocationService {
  final DioClient _dioClient;

  LocationService(this._dioClient);

  // Get Location by ID
  Future<Location> getLocationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/location/$id');
      return Location.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all locations
  Future<List<Location>> getLocations({
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

      final response = await _dioClient.get('/api/v1/location', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Location.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Location
  Future<Location> createLocation(Location location) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/location',
        data: location.toJson(),
      );
      return Location.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Location
  Future<Location> updateLocation(String id, Location location) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/location/$id',
        data: location.toJson(),
      );
      return Location.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Location
  Future<void> deleteLocation(String id) async {
    try {
      await _dioClient.delete('/api/v1/location/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
