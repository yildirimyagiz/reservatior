import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiValuationModelService {
  final DioClient _dioClient;
  AiValuationModelService(this._dioClient);

  Future<AiValuationModel> getAiValuationModelById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiValuationModels}/$id');
    return AiValuationModel.fromJson(response.data['data']);
  }

  Future<List<AiValuationModel>> getAiValuationModels({
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
    final response = await _dioClient.get(ApiEndpoints.aiValuationModels, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiValuationModel.fromJson(json)).toList();
  }

  Future<AiValuationModel> createAiValuationModel(AiValuationModel item) async {
    final response = await _dioClient.post(ApiEndpoints.aiValuationModels, data: item.toJson());
    return AiValuationModel.fromJson(response.data['data']);
  }

  Future<AiValuationModel> updateAiValuationModel(String id, AiValuationModel item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiValuationModels}/$id', data: item.toJson());
    return AiValuationModel.fromJson(response.data['data']);
  }

  Future<void> deleteAiValuationModel(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiValuationModels}/$id');
  }
}
