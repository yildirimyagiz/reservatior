import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class QueueConfigurationService {
  final DioClient _dioClient;

  QueueConfigurationService(this._dioClient);

  // Get QueueConfiguration by ID
  Future<QueueConfiguration> getQueueConfigurationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/queue_configuration/$id');
      return QueueConfiguration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all queue_configurations
  Future<List<QueueConfiguration>> getQueueConfigurations({
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

      final response = await _dioClient.get('/api/v1/queue_configuration', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => QueueConfiguration.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create QueueConfiguration
  Future<QueueConfiguration> createQueueConfiguration(QueueConfiguration queueConfiguration) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/queue_configuration',
        data: queueConfiguration.toJson(),
      );
      return QueueConfiguration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update QueueConfiguration
  Future<QueueConfiguration> updateQueueConfiguration(String id, QueueConfiguration queueConfiguration) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/queue_configuration/$id',
        data: queueConfiguration.toJson(),
      );
      return QueueConfiguration.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete QueueConfiguration
  Future<void> deleteQueueConfiguration(String id) async {
    try {
      await _dioClient.delete('/api/v1/queue_configuration/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
