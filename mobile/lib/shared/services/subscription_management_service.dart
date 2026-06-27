import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class SubscriptionManagementService {
  final DioClient _dioClient;

  SubscriptionManagementService(this._dioClient);

  Future<Subscription?> getCurrentSubscription() async {
    final response = await _dioClient.get('${ApiEndpoints.subscriptions}/me');
    return Subscription.fromJson(response.data['data']);
  }

  Future<List<Plan>> getAvailablePlans() async {
    final response = await _dioClient.get(ApiEndpoints.plans);
    final data = response.data['data'] as List;
    return data.map((json) => Plan.fromJson(json)).toList();
  }

  Future<Subscription> subscribe(String planId, {String? paymentMethodId}) async {
    final response = await _dioClient.post(ApiEndpoints.subscriptions, data: {
      'planId': planId,
      if (paymentMethodId != null) 'paymentMethodId': paymentMethodId,
    });
    return Subscription.fromJson(response.data['data']);
  }

  Future<void> cancelSubscription(String subscriptionId) async {
    await _dioClient.post('${ApiEndpoints.subscriptions}/$subscriptionId/cancel');
  }

  Future<UsageMetrics?> getUsageMetrics() async {
    final response = await _dioClient.get('${ApiEndpoints.subscriptions}/usage');
    return UsageMetrics.fromJson(response.data['data']);
  }
}
