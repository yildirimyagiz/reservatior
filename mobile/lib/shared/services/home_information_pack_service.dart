import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class HomeInformationPackService {
  final DioClient _dioClient;
  HomeInformationPackService(this._dioClient);

  Future<HomeInformationPack> getHomeInformationPackById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.homeInformationPacks}/$id');
    return HomeInformationPack.fromJson(response.data['data']);
  }

  Future<List<HomeInformationPack>> getHomeInformationPacks({
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
    final response = await _dioClient.get(ApiEndpoints.homeInformationPacks, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => HomeInformationPack.fromJson(json)).toList();
  }

  Future<HomeInformationPack> createHomeInformationPack(HomeInformationPack item) async {
    final response = await _dioClient.post(ApiEndpoints.homeInformationPacks, data: item.toJson());
    return HomeInformationPack.fromJson(response.data['data']);
  }

  Future<HomeInformationPack> updateHomeInformationPack(String id, HomeInformationPack item) async {
    final response = await _dioClient.patch('${ApiEndpoints.homeInformationPacks}/$id', data: item.toJson());
    return HomeInformationPack.fromJson(response.data['data']);
  }

  Future<void> deleteHomeInformationPack(String id) async {
    await _dioClient.delete('${ApiEndpoints.homeInformationPacks}/$id');
  }
}
