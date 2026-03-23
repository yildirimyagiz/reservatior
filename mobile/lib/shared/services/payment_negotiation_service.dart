import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PaymentNegotiationService {
  final DioClient _dioClient;

  PaymentNegotiationService(this._dioClient);

  // Get PaymentNegotiation by ID
  Future<PaymentNegotiation> getPaymentNegotiationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/payment_negotiation/$id');
      return PaymentNegotiation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all payment_negotiations
  Future<List<PaymentNegotiation>> getPaymentNegotiations({
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

      final response = await _dioClient.get('/api/v1/payment_negotiation', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => PaymentNegotiation.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create PaymentNegotiation
  Future<PaymentNegotiation> createPaymentNegotiation(PaymentNegotiation paymentNegotiation) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/payment_negotiation',
        data: paymentNegotiation.toJson(),
      );
      return PaymentNegotiation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PaymentNegotiation
  Future<PaymentNegotiation> updatePaymentNegotiation(String id, PaymentNegotiation paymentNegotiation) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/payment_negotiation/$id',
        data: paymentNegotiation.toJson(),
      );
      return PaymentNegotiation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PaymentNegotiation
  Future<void> deletePaymentNegotiation(String id) async {
    try {
      await _dioClient.delete('/api/v1/payment_negotiation/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
