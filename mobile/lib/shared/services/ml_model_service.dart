import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MlModelService {
  final DioClient _dioClient;
  MlModelService(this._dioClient);

  Future<MlModel> getMlModelById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.mlModels}/$id');
    return MlModel.fromJson(response.data['data']);
  }

  Future<List<MlModel>> getMlModels({
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
    final response = await _dioClient.get(ApiEndpoints.mlModels, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => MlModel.fromJson(json)).toList();
  }

  Future<MlModel> createMlModel(MlModel item) async {
    final response = await _dioClient.post(ApiEndpoints.mlModels, data: item.toJson());
    return MlModel.fromJson(response.data['data']);
  }

  Future<MlModel> updateMlModel(String id, MlModel item) async {
    final response = await _dioClient.patch('${ApiEndpoints.mlModels}/$id', data: item.toJson());
    return MlModel.fromJson(response.data['data']);
  }

  Future<void> deleteMlModel(String id) async {
    await _dioClient.delete('${ApiEndpoints.mlModels}/$id');
  }
}
