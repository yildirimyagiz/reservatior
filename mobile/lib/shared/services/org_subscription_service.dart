import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class OrgSubscriptionService {
  final DioClient _dioClient;

  OrgSubscriptionService(this._dioClient);

  // Get OrgSubscription by ID
  Future<OrgSubscription> getOrgSubscriptionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/org_subscription/$id');
      return OrgSubscription.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all org_subscriptions
  Future<List<OrgSubscription>> getOrgSubscriptions({
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

      final response = await _dioClient.get('/api/v1/org_subscription', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => OrgSubscription.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create OrgSubscription
  Future<OrgSubscription> createOrgSubscription(OrgSubscription orgSubscription) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/org_subscription',
        data: orgSubscription.toJson(),
      );
      return OrgSubscription.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update OrgSubscription
  Future<OrgSubscription> updateOrgSubscription(String id, OrgSubscription orgSubscription) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/org_subscription/$id',
        data: orgSubscription.toJson(),
      );
      return OrgSubscription.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete OrgSubscription
  Future<void> deleteOrgSubscription(String id) async {
    try {
      await _dioClient.delete('/api/v1/org_subscription/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
