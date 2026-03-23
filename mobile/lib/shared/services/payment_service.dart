import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PaymentService {
  final DioClient _dioClient;

  PaymentService(this._dioClient);

  // Get Payment by ID
  Future<Payment> getPaymentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/payment/$id');
      return Payment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all payments
  Future<List<Payment>> getPayments({
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

      final response = await _dioClient.get('/api/v1/payment', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Payment.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Payment
  Future<Payment> createPayment(Payment payment) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/payment',
        data: payment.toJson(),
      );
      return Payment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Payment
  Future<Payment> updatePayment(String id, Payment payment) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/payment/$id',
        data: payment.toJson(),
      );
      return Payment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Payment
  Future<void> deletePayment(String id) async {
    try {
      await _dioClient.delete('/api/v1/payment/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
