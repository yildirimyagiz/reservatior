import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MLModelService {
  final DioClient _dioClient;

  MLModelService(this._dioClient);

  // Get MLModel by ID
  Future<MLModel> getMLModelById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/m_l_model/$id');
      return MLModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all m_l_models
  Future<List<MLModel>> getMLModels({
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

      final response = await _dioClient.get('/api/v1/m_l_model', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MLModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MLModel
  Future<MLModel> createMLModel(MLModel mLModel) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/m_l_model',
        data: mLModel.toJson(),
      );
      return MLModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MLModel
  Future<MLModel> updateMLModel(String id, MLModel mLModel) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/m_l_model/$id',
        data: mLModel.toJson(),
      );
      return MLModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MLModel
  Future<void> deleteMLModel(String id) async {
    try {
      await _dioClient.delete('/api/v1/m_l_model/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
