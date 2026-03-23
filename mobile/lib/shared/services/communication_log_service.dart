import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class CommunicationLogService {
  final DioClient _dioClient;

  CommunicationLogService(this._dioClient);

  // Get CommunicationLog by ID
  Future<CommunicationLog> getCommunicationLogById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/communication_log/$id');
      return CommunicationLog.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all communication_logs
  Future<List<CommunicationLog>> getCommunicationLogs({
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

      final response = await _dioClient.get('/api/v1/communication_log', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => CommunicationLog.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create CommunicationLog
  Future<CommunicationLog> createCommunicationLog(CommunicationLog communicationLog) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/communication_log',
        data: communicationLog.toJson(),
      );
      return CommunicationLog.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update CommunicationLog
  Future<CommunicationLog> updateCommunicationLog(String id, CommunicationLog communicationLog) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/communication_log/$id',
        data: communicationLog.toJson(),
      );
      return CommunicationLog.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete CommunicationLog
  Future<void> deleteCommunicationLog(String id) async {
    try {
      await _dioClient.delete('/api/v1/communication_log/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
