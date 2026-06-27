import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class VirtualTourService {
  final DioClient _dioClient;
  VirtualTourService(this._dioClient);

  Future<VirtualTour> getVirtualTourById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.virtualTours}/$id');
    return VirtualTour.fromJson(response.data['data']);
  }

  Future<List<VirtualTour>> getVirtualTours({
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
    final response = await _dioClient.get(ApiEndpoints.virtualTours, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => VirtualTour.fromJson(json)).toList();
  }

  Future<VirtualTour> createVirtualTour(VirtualTour item) async {
    final response = await _dioClient.post(ApiEndpoints.virtualTours, data: item.toJson());
    return VirtualTour.fromJson(response.data['data']);
  }

  Future<VirtualTour> updateVirtualTour(String id, VirtualTour item) async {
    final response = await _dioClient.patch('${ApiEndpoints.virtualTours}/$id', data: item.toJson());
    return VirtualTour.fromJson(response.data['data']);
  }

  Future<void> deleteVirtualTour(String id) async {
    await _dioClient.delete('${ApiEndpoints.virtualTours}/$id');
  }
}
