import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiPropertyDescriptionService {
  final DioClient _dioClient;
  AiPropertyDescriptionService(this._dioClient);

  Future<AiPropertyDescription> getAiPropertyDescriptionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiPropertyDescriptions}/$id');
    return AiPropertyDescription.fromJson(response.data['data']);
  }

  Future<List<AiPropertyDescription>> getAiPropertyDescriptions({
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
    final response = await _dioClient.get(ApiEndpoints.aiPropertyDescriptions, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiPropertyDescription.fromJson(json)).toList();
  }

  Future<AiPropertyDescription> createAiPropertyDescription(AiPropertyDescription item) async {
    final response = await _dioClient.post(ApiEndpoints.aiPropertyDescriptions, data: item.toJson());
    return AiPropertyDescription.fromJson(response.data['data']);
  }

  Future<AiPropertyDescription> updateAiPropertyDescription(String id, AiPropertyDescription item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiPropertyDescriptions}/$id', data: item.toJson());
    return AiPropertyDescription.fromJson(response.data['data']);
  }

  Future<void> deleteAiPropertyDescription(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiPropertyDescriptions}/$id');
  }
}
