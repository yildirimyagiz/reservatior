import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class RouteService {
  final DioClient _dioClient;
  RouteService(this._dioClient);

  Future<Route> getRouteById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.routes}/$id');
    return Route.fromJson(response.data['data']);
  }

  Future<List<Route>> getRoutes({
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
    final response = await _dioClient.get(ApiEndpoints.routes, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Route.fromJson(json)).toList();
  }

  Future<Route> createRoute(Route item) async {
    final response = await _dioClient.post(ApiEndpoints.routes, data: item.toJson());
    return Route.fromJson(response.data['data']);
  }

  Future<Route> updateRoute(String id, Route item) async {
    final response = await _dioClient.patch('${ApiEndpoints.routes}/$id', data: item.toJson());
    return Route.fromJson(response.data['data']);
  }

  Future<void> deleteRoute(String id) async {
    await _dioClient.delete('${ApiEndpoints.routes}/$id');
  }
}
