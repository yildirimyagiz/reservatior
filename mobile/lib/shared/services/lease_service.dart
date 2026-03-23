import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class LeaseService {
  final DioClient _dioClient;

  LeaseService(this._dioClient);

  // Get Lease by ID
  Future<Lease> getLeaseById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/lease/$id');
      return Lease.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all leases
  Future<List<Lease>> getLeases({
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

      final response = await _dioClient.get('/api/v1/lease', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Lease.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Lease
  Future<Lease> createLease(Lease lease) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/lease',
        data: lease.toJson(),
      );
      return Lease.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Lease
  Future<Lease> updateLease(String id, Lease lease) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/lease/$id',
        data: lease.toJson(),
      );
      return Lease.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Lease
  Future<void> deleteLease(String id) async {
    try {
      await _dioClient.delete('/api/v1/lease/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
