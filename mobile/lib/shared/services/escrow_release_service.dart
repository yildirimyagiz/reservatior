import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class EscrowReleaseService {
  final DioClient _dioClient;

  EscrowReleaseService(this._dioClient);

  // Get EscrowRelease by ID
  Future<EscrowRelease> getEscrowReleaseById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/escrow_release/$id');
      return EscrowRelease.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all escrow_releases
  Future<List<EscrowRelease>> getEscrowReleases({
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

      final response = await _dioClient.get('/api/v1/escrow_release', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => EscrowRelease.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create EscrowRelease
  Future<EscrowRelease> createEscrowRelease(EscrowRelease escrowRelease) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/escrow_release',
        data: escrowRelease.toJson(),
      );
      return EscrowRelease.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update EscrowRelease
  Future<EscrowRelease> updateEscrowRelease(String id, EscrowRelease escrowRelease) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/escrow_release/$id',
        data: escrowRelease.toJson(),
      );
      return EscrowRelease.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete EscrowRelease
  Future<void> deleteEscrowRelease(String id) async {
    try {
      await _dioClient.delete('/api/v1/escrow_release/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
