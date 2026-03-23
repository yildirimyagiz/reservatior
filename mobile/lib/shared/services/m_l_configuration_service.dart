import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MLConfigurationService {
  final DioClient _dioClient;

  MLConfigurationService(this._dioClient);

  // Get MLConfiguration by ID
  Future<MLConfiguration> getMLConfigurationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/m_l_configuration/$id');
      return MLConfiguration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all m_l_configurations
  Future<List<MLConfiguration>> getMLConfigurations({
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

      final response = await _dioClient.get('/api/v1/m_l_configuration', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MLConfiguration.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MLConfiguration
  Future<MLConfiguration> createMLConfiguration(MLConfiguration mLConfiguration) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/m_l_configuration',
        data: mLConfiguration.toJson(),
      );
      return MLConfiguration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MLConfiguration
  Future<MLConfiguration> updateMLConfiguration(String id, MLConfiguration mLConfiguration) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/m_l_configuration/$id',
        data: mLConfiguration.toJson(),
      );
      return MLConfiguration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MLConfiguration
  Future<void> deleteMLConfiguration(String id) async {
    try {
      await _dioClient.delete('/api/v1/m_l_configuration/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
