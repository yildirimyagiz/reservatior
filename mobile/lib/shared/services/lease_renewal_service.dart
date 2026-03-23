import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class LeaseRenewalService {
  final DioClient _dioClient;

  LeaseRenewalService(this._dioClient);

  // Get LeaseRenewal by ID
  Future<LeaseRenewal> getLeaseRenewalById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/lease_renewal/$id');
      return LeaseRenewal.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all lease_renewals
  Future<List<LeaseRenewal>> getLeaseRenewals({
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

      final response = await _dioClient.get('/api/v1/lease_renewal', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => LeaseRenewal.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create LeaseRenewal
  Future<LeaseRenewal> createLeaseRenewal(LeaseRenewal leaseRenewal) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/lease_renewal',
        data: leaseRenewal.toJson(),
      );
      return LeaseRenewal.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update LeaseRenewal
  Future<LeaseRenewal> updateLeaseRenewal(String id, LeaseRenewal leaseRenewal) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/lease_renewal/$id',
        data: leaseRenewal.toJson(),
      );
      return LeaseRenewal.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete LeaseRenewal
  Future<void> deleteLeaseRenewal(String id) async {
    try {
      await _dioClient.delete('/api/v1/lease_renewal/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
