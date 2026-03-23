import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class NeighborhoodService {
  final DioClient _dioClient;

  NeighborhoodService(this._dioClient);

  // Get Neighborhood by ID
  Future<Neighborhood> getNeighborhoodById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/neighborhood/$id');
      return Neighborhood.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all neighborhoods
  Future<List<Neighborhood>> getNeighborhoods({
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

      final response = await _dioClient.get('/api/v1/neighborhood', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Neighborhood.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Neighborhood
  Future<Neighborhood> createNeighborhood(Neighborhood neighborhood) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/neighborhood',
        data: neighborhood.toJson(),
      );
      return Neighborhood.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Neighborhood
  Future<Neighborhood> updateNeighborhood(String id, Neighborhood neighborhood) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/neighborhood/$id',
        data: neighborhood.toJson(),
      );
      return Neighborhood.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Neighborhood
  Future<void> deleteNeighborhood(String id) async {
    try {
      await _dioClient.delete('/api/v1/neighborhood/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
