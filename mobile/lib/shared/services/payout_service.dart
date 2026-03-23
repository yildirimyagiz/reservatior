import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PayoutService {
  final DioClient _dioClient;

  PayoutService(this._dioClient);

  // Get Payout by ID
  Future<Payout> getPayoutById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/payout/$id');
      return Payout.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all payouts
  Future<List<Payout>> getPayouts({
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

      final response = await _dioClient.get('/api/v1/payout', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Payout.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Payout
  Future<Payout> createPayout(Payout payout) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/payout',
        data: payout.toJson(),
      );
      return Payout.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Payout
  Future<Payout> updatePayout(String id, Payout payout) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/payout/$id',
        data: payout.toJson(),
      );
      return Payout.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Payout
  Future<void> deletePayout(String id) async {
    try {
      await _dioClient.delete('/api/v1/payout/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
