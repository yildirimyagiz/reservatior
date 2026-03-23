import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class CommissionService {
  final DioClient _dioClient;

  CommissionService(this._dioClient);

  // Get Commission by ID
  Future<Commission> getCommissionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/commission/$id');
      return Commission.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all commissions
  Future<List<Commission>> getCommissions({
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

      final response = await _dioClient.get('/api/v1/commission', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Commission.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Commission
  Future<Commission> createCommission(Commission commission) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/commission',
        data: commission.toJson(),
      );
      return Commission.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Commission
  Future<Commission> updateCommission(String id, Commission commission) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/commission/$id',
        data: commission.toJson(),
      );
      return Commission.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Commission
  Future<void> deleteCommission(String id) async {
    try {
      await _dioClient.delete('/api/v1/commission/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
