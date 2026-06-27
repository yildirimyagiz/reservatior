import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class SubscriptionService {
  final DioClient _dioClient;
  SubscriptionService(this._dioClient);

  Future<Subscription> getSubscriptionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.subscriptions}/$id');
    return Subscription.fromJson(response.data['data']);
  }

  Future<List<Subscription>> getSubscriptions({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.subscriptions, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Subscription.fromJson(json)).toList();
  }

  Future<Subscription> createSubscription(Subscription item) async {
    final response = await _dioClient.post(ApiEndpoints.subscriptions, data: item.toJson());
    return Subscription.fromJson(response.data['data']);
  }

  Future<Subscription> updateSubscription(String id, Subscription item) async {
    final response = await _dioClient.patch('${ApiEndpoints.subscriptions}/$id', data: item.toJson());
    return Subscription.fromJson(response.data['data']);
  }

  Future<void> deleteSubscription(String id) async {
    await _dioClient.delete('${ApiEndpoints.subscriptions}/$id');
  }
}
