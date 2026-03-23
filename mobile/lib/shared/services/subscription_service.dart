import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class SubscriptionService {
  final DioClient _dioClient;

  SubscriptionService(this._dioClient);

  // Get Subscription by ID
  Future<Subscription> getSubscriptionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/subscription/$id');
      return Subscription.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all subscriptions
  Future<List<Subscription>> getSubscriptions({
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

      final response = await _dioClient.get('/api/v1/subscription', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Subscription.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Subscription
  Future<Subscription> createSubscription(Subscription subscription) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/subscription',
        data: subscription.toJson(),
      );
      return Subscription.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Subscription
  Future<Subscription> updateSubscription(String id, Subscription subscription) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/subscription/$id',
        data: subscription.toJson(),
      );
      return Subscription.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Subscription
  Future<void> deleteSubscription(String id) async {
    try {
      await _dioClient.delete('/api/v1/subscription/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
