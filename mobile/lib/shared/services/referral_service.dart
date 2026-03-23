import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ReferralService {
  final DioClient _dioClient;

  ReferralService(this._dioClient);

  // Get Referral by ID
  Future<Referral> getReferralById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/referral/$id');
      return Referral.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all referrals
  Future<List<Referral>> getReferrals({
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

      final response = await _dioClient.get('/api/v1/referral', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Referral.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Referral
  Future<Referral> createReferral(Referral referral) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/referral',
        data: referral.toJson(),
      );
      return Referral.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Referral
  Future<Referral> updateReferral(String id, Referral referral) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/referral/$id',
        data: referral.toJson(),
      );
      return Referral.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Referral
  Future<void> deleteReferral(String id) async {
    try {
      await _dioClient.delete('/api/v1/referral/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
