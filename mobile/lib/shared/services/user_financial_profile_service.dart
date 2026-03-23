import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class UserFinancialProfileService {
  final DioClient _dioClient;

  UserFinancialProfileService(this._dioClient);

  // Get UserFinancialProfile by ID
  Future<UserFinancialProfile> getUserFinancialProfileById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/user_financial_profile/$id');
      return UserFinancialProfile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all user_financial_profiles
  Future<List<UserFinancialProfile>> getUserFinancialProfiles({
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

      final response = await _dioClient.get('/api/v1/user_financial_profile', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => UserFinancialProfile.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create UserFinancialProfile
  Future<UserFinancialProfile> createUserFinancialProfile(UserFinancialProfile userFinancialProfile) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/user_financial_profile',
        data: userFinancialProfile.toJson(),
      );
      return UserFinancialProfile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update UserFinancialProfile
  Future<UserFinancialProfile> updateUserFinancialProfile(String id, UserFinancialProfile userFinancialProfile) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/user_financial_profile/$id',
        data: userFinancialProfile.toJson(),
      );
      return UserFinancialProfile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete UserFinancialProfile
  Future<void> deleteUserFinancialProfile(String id) async {
    try {
      await _dioClient.delete('/api/v1/user_financial_profile/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
