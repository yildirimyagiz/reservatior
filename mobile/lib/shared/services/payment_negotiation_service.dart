import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PaymentNegotiationService {
  final DioClient _dioClient;
  PaymentNegotiationService(this._dioClient);

  Future<PaymentNegotiation> getPaymentNegotiationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.paymentNegotiations}/$id');
    return PaymentNegotiation.fromJson(response.data['data']);
  }

  Future<List<PaymentNegotiation>> getPaymentNegotiations({
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
    final response = await _dioClient.get(ApiEndpoints.paymentNegotiations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PaymentNegotiation.fromJson(json)).toList();
  }

  Future<PaymentNegotiation> createPaymentNegotiation(PaymentNegotiation item) async {
    final response = await _dioClient.post(ApiEndpoints.paymentNegotiations, data: item.toJson());
    return PaymentNegotiation.fromJson(response.data['data']);
  }

  Future<PaymentNegotiation> updatePaymentNegotiation(String id, PaymentNegotiation item) async {
    final response = await _dioClient.patch('${ApiEndpoints.paymentNegotiations}/$id', data: item.toJson());
    return PaymentNegotiation.fromJson(response.data['data']);
  }

  Future<void> deletePaymentNegotiation(String id) async {
    await _dioClient.delete('${ApiEndpoints.paymentNegotiations}/$id');
  }
}
