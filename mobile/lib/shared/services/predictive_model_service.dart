import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PredictiveModelService {
  final DioClient _dioClient;

  PredictiveModelService(this._dioClient);

  // Get PredictiveModel by ID
  Future<PredictiveModel> getPredictiveModelById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/predictive_model/$id');
      return PredictiveModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all predictive_models
  Future<List<PredictiveModel>> getPredictiveModels({
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

      final response = await _dioClient.get('/api/v1/predictive_model', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PredictiveModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PredictiveModel
  Future<PredictiveModel> createPredictiveModel(PredictiveModel predictiveModel) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/predictive_model',
        data: predictiveModel.toJson(),
      );
      return PredictiveModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PredictiveModel
  Future<PredictiveModel> updatePredictiveModel(String id, PredictiveModel predictiveModel) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/predictive_model/$id',
        data: predictiveModel.toJson(),
      );
      return PredictiveModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PredictiveModel
  Future<void> deletePredictiveModel(String id) async {
    try {
      await _dioClient.delete('/api/v1/predictive_model/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
