import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class VerificationService {
  final DioClient _dioClient;

  VerificationService(this._dioClient);

  // Get Verification by ID
  Future<Verification> getVerificationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/verification/$id');
      return Verification.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all verifications
  Future<List<Verification>> getVerifications({
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

      final response = await _dioClient.get('/api/v1/verification', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Verification.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Verification
  Future<Verification> createVerification(Verification verification) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/verification',
        data: verification.toJson(),
      );
      return Verification.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Verification
  Future<Verification> updateVerification(String id, Verification verification) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/verification/$id',
        data: verification.toJson(),
      );
      return Verification.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Verification
  Future<void> deleteVerification(String id) async {
    try {
      await _dioClient.delete('/api/v1/verification/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
