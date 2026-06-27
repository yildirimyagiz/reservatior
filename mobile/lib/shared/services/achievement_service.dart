import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AchievementService {
  final DioClient _dioClient;
  AchievementService(this._dioClient);

  Future<Achievement> getAchievementById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.achievements}/$id');
    return Achievement.fromJson(response.data['data']);
  }

  Future<List<Achievement>> getAchievements({
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
    final response = await _dioClient.get(ApiEndpoints.achievements, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Achievement.fromJson(json)).toList();
  }

  Future<Achievement> createAchievement(Achievement item) async {
    final response = await _dioClient.post(ApiEndpoints.achievements, data: item.toJson());
    return Achievement.fromJson(response.data['data']);
  }

  Future<Achievement> updateAchievement(String id, Achievement item) async {
    final response = await _dioClient.patch('${ApiEndpoints.achievements}/$id', data: item.toJson());
    return Achievement.fromJson(response.data['data']);
  }

  Future<void> deleteAchievement(String id) async {
    await _dioClient.delete('${ApiEndpoints.achievements}/$id');
  }
}
