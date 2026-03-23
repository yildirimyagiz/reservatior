import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class VirtualTourService {
  final DioClient _dioClient;

  VirtualTourService(this._dioClient);

  // Get VirtualTour by ID
  Future<VirtualTour> getVirtualTourById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/virtual_tour/$id');
      return VirtualTour.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all virtual_tours
  Future<List<VirtualTour>> getVirtualTours({
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

      final response = await _dioClient.get('/api/v1/virtual_tour', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => VirtualTour.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create VirtualTour
  Future<VirtualTour> createVirtualTour(VirtualTour virtualTour) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/virtual_tour',
        data: virtualTour.toJson(),
      );
      return VirtualTour.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update VirtualTour
  Future<VirtualTour> updateVirtualTour(String id, VirtualTour virtualTour) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/virtual_tour/$id',
        data: virtualTour.toJson(),
      );
      return VirtualTour.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete VirtualTour
  Future<void> deleteVirtualTour(String id) async {
    try {
      await _dioClient.delete('/api/v1/virtual_tour/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
