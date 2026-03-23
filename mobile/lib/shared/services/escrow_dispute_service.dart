import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class EscrowDisputeService {
  final DioClient _dioClient;

  EscrowDisputeService(this._dioClient);

  // Get EscrowDispute by ID
  Future<EscrowDispute> getEscrowDisputeById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/escrow_dispute/$id');
      return EscrowDispute.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all escrow_disputes
  Future<List<EscrowDispute>> getEscrowDisputes({
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

      final response = await _dioClient.get('/api/v1/escrow_dispute', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => EscrowDispute.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create EscrowDispute
  Future<EscrowDispute> createEscrowDispute(EscrowDispute escrowDispute) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/escrow_dispute',
        data: escrowDispute.toJson(),
      );
      return EscrowDispute.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update EscrowDispute
  Future<EscrowDispute> updateEscrowDispute(String id, EscrowDispute escrowDispute) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/escrow_dispute/$id',
        data: escrowDispute.toJson(),
      );
      return EscrowDispute.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete EscrowDispute
  Future<void> deleteEscrowDispute(String id) async {
    try {
      await _dioClient.delete('/api/v1/escrow_dispute/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
