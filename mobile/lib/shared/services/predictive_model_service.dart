import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PredictiveModelService {
  final DioClient _dioClient;
  PredictiveModelService(this._dioClient);

  Future<PredictiveModel> getPredictiveModelById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.predictiveModels}/$id');
    return PredictiveModel.fromJson(response.data['data']);
  }

  Future<List<PredictiveModel>> getPredictiveModels({
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
    final response = await _dioClient.get(ApiEndpoints.predictiveModels, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PredictiveModel.fromJson(json)).toList();
  }

  Future<PredictiveModel> createPredictiveModel(PredictiveModel item) async {
    final response = await _dioClient.post(ApiEndpoints.predictiveModels, data: item.toJson());
    return PredictiveModel.fromJson(response.data['data']);
  }

  Future<PredictiveModel> updatePredictiveModel(String id, PredictiveModel item) async {
    final response = await _dioClient.patch('${ApiEndpoints.predictiveModels}/$id', data: item.toJson());
    return PredictiveModel.fromJson(response.data['data']);
  }

  Future<void> deletePredictiveModel(String id) async {
    await _dioClient.delete('${ApiEndpoints.predictiveModels}/$id');
  }
}
