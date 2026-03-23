import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PaymentInstallmentService {
  final DioClient _dioClient;

  PaymentInstallmentService(this._dioClient);

  // Get PaymentInstallment by ID
  Future<PaymentInstallment> getPaymentInstallmentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/payment_installment/$id');
      return PaymentInstallment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all payment_installments
  Future<List<PaymentInstallment>> getPaymentInstallments({
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

      final response = await _dioClient.get('/api/v1/payment_installment', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PaymentInstallment.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PaymentInstallment
  Future<PaymentInstallment> createPaymentInstallment(PaymentInstallment paymentInstallment) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/payment_installment',
        data: paymentInstallment.toJson(),
      );
      return PaymentInstallment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PaymentInstallment
  Future<PaymentInstallment> updatePaymentInstallment(String id, PaymentInstallment paymentInstallment) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/payment_installment/$id',
        data: paymentInstallment.toJson(),
      );
      return PaymentInstallment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PaymentInstallment
  Future<void> deletePaymentInstallment(String id) async {
    try {
      await _dioClient.delete('/api/v1/payment_installment/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
