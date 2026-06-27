import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class EscrowStatusHistoryService {
  final DioClient _dioClient;
  EscrowStatusHistoryService(this._dioClient);

  Future<EscrowStatusHistory> getEscrowStatusHistoryById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.escrowStatusHistories}/$id');
    return EscrowStatusHistory.fromJson(response.data['data']);
  }

  Future<List<EscrowStatusHistory>> getEscrowStatusHistories({
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
    final response = await _dioClient.get(ApiEndpoints.escrowStatusHistories, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => EscrowStatusHistory.fromJson(json)).toList();
  }

  Future<EscrowStatusHistory> createEscrowStatusHistory(EscrowStatusHistory item) async {
    final response = await _dioClient.post(ApiEndpoints.escrowStatusHistories, data: item.toJson());
    return EscrowStatusHistory.fromJson(response.data['data']);
  }

  Future<EscrowStatusHistory> updateEscrowStatusHistory(String id, EscrowStatusHistory item) async {
    final response = await _dioClient.patch('${ApiEndpoints.escrowStatusHistories}/$id', data: item.toJson());
    return EscrowStatusHistory.fromJson(response.data['data']);
  }

  Future<void> deleteEscrowStatusHistory(String id) async {
    await _dioClient.delete('${ApiEndpoints.escrowStatusHistories}/$id');
  }
}
