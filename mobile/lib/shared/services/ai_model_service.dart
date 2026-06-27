import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiModelService {
  final DioClient _dioClient;
  AiModelService(this._dioClient);

  Future<AiModel> getAiModelById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiModels}/$id');
    return AiModel.fromJson(response.data['data']);
  }

  Future<List<AiModel>> getAiModels({
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
    final response = await _dioClient.get(ApiEndpoints.aiModels, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiModel.fromJson(json)).toList();
  }

  Future<AiModel> createAiModel(AiModel item) async {
    final response = await _dioClient.post(ApiEndpoints.aiModels, data: item.toJson());
    return AiModel.fromJson(response.data['data']);
  }

  Future<AiModel> updateAiModel(String id, AiModel item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiModels}/$id', data: item.toJson());
    return AiModel.fromJson(response.data['data']);
  }

  Future<void> deleteAiModel(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiModels}/$id');
  }
}
