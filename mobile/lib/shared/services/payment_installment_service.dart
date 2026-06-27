import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PaymentInstallmentService {
  final DioClient _dioClient;
  PaymentInstallmentService(this._dioClient);

  Future<PaymentInstallment> getPaymentInstallmentById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.paymentInstallments}/$id');
    return PaymentInstallment.fromJson(response.data['data']);
  }

  Future<List<PaymentInstallment>> getPaymentInstallments({
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
    final response = await _dioClient.get(ApiEndpoints.paymentInstallments, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PaymentInstallment.fromJson(json)).toList();
  }

  Future<PaymentInstallment> createPaymentInstallment(PaymentInstallment item) async {
    final response = await _dioClient.post(ApiEndpoints.paymentInstallments, data: item.toJson());
    return PaymentInstallment.fromJson(response.data['data']);
  }

  Future<PaymentInstallment> updatePaymentInstallment(String id, PaymentInstallment item) async {
    final response = await _dioClient.patch('${ApiEndpoints.paymentInstallments}/$id', data: item.toJson());
    return PaymentInstallment.fromJson(response.data['data']);
  }

  Future<void> deletePaymentInstallment(String id) async {
    await _dioClient.delete('${ApiEndpoints.paymentInstallments}/$id');
  }
}
