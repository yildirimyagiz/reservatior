import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class EscrowStatusHistoryService {
  final DioClient _dioClient;

  EscrowStatusHistoryService(this._dioClient);

  // Get EscrowStatusHistory by ID
  Future<EscrowStatusHistory> getEscrowStatusHistoryById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/escrow_status_history/$id');
      return EscrowStatusHistory.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all escrow_status_historys
  Future<List<EscrowStatusHistory>> getEscrowStatusHistorys({
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

      final response = await _dioClient.get('/api/v1/escrow_status_history', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => EscrowStatusHistory.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create EscrowStatusHistory
  Future<EscrowStatusHistory> createEscrowStatusHistory(EscrowStatusHistory escrowStatusHistory) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/escrow_status_history',
        data: escrowStatusHistory.toJson(),
      );
      return EscrowStatusHistory.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update EscrowStatusHistory
  Future<EscrowStatusHistory> updateEscrowStatusHistory(String id, EscrowStatusHistory escrowStatusHistory) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/escrow_status_history/$id',
        data: escrowStatusHistory.toJson(),
      );
      return EscrowStatusHistory.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete EscrowStatusHistory
  Future<void> deleteEscrowStatusHistory(String id) async {
    try {
      await _dioClient.delete('/api/v1/escrow_status_history/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
