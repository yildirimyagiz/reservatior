import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class CommunicationLogService {
  final DioClient _dioClient;
  CommunicationLogService(this._dioClient);

  Future<CommunicationLog> getCommunicationLogById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.communicationLogs}/$id');
    return CommunicationLog.fromJson(response.data['data']);
  }

  Future<List<CommunicationLog>> getCommunicationLogs({
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
    final response = await _dioClient.get(ApiEndpoints.communicationLogs, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => CommunicationLog.fromJson(json)).toList();
  }

  Future<CommunicationLog> createCommunicationLog(CommunicationLog item) async {
    final response = await _dioClient.post(ApiEndpoints.communicationLogs, data: item.toJson());
    return CommunicationLog.fromJson(response.data['data']);
  }

  Future<CommunicationLog> updateCommunicationLog(String id, CommunicationLog item) async {
    final response = await _dioClient.patch('${ApiEndpoints.communicationLogs}/$id', data: item.toJson());
    return CommunicationLog.fromJson(response.data['data']);
  }

  Future<void> deleteCommunicationLog(String id) async {
    await _dioClient.delete('${ApiEndpoints.communicationLogs}/$id');
  }
}
