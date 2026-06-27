import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PaymentService {
  final DioClient _dioClient;
  PaymentService(this._dioClient);

  Future<Payment> getPaymentById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.payments}/$id');
    return Payment.fromJson(response.data['data']);
  }

  Future<List<Payment>> getPayments({
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
    final response = await _dioClient.get(ApiEndpoints.payments, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Payment.fromJson(json)).toList();
  }

  Future<Payment> createPayment(Payment item) async {
    final response = await _dioClient.post(ApiEndpoints.payments, data: item.toJson());
    return Payment.fromJson(response.data['data']);
  }

  Future<Payment> updatePayment(String id, Payment item) async {
    final response = await _dioClient.patch('${ApiEndpoints.payments}/$id', data: item.toJson());
    return Payment.fromJson(response.data['data']);
  }

  Future<void> deletePayment(String id) async {
    await _dioClient.delete('${ApiEndpoints.payments}/$id');
  }
}
