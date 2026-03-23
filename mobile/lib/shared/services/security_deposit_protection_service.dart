import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class SecurityDepositProtectionService {
  final DioClient _dioClient;

  SecurityDepositProtectionService(this._dioClient);

  // Get SecurityDepositProtection by ID
  Future<SecurityDepositProtection> getSecurityDepositProtectionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/security_deposit_protection/$id');
      return SecurityDepositProtection.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all security_deposit_protections
  Future<List<SecurityDepositProtection>> getSecurityDepositProtections({
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

      final response = await _dioClient.get('/api/v1/security_deposit_protection', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => SecurityDepositProtection.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create SecurityDepositProtection
  Future<SecurityDepositProtection> createSecurityDepositProtection(SecurityDepositProtection securityDepositProtection) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/security_deposit_protection',
        data: securityDepositProtection.toJson(),
      );
      return SecurityDepositProtection.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update SecurityDepositProtection
  Future<SecurityDepositProtection> updateSecurityDepositProtection(String id, SecurityDepositProtection securityDepositProtection) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/security_deposit_protection/$id',
        data: securityDepositProtection.toJson(),
      );
      return SecurityDepositProtection.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete SecurityDepositProtection
  Future<void> deleteSecurityDepositProtection(String id) async {
    try {
      await _dioClient.delete('/api/v1/security_deposit_protection/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
