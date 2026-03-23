import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class PaymentNegotiationService {
  final DioClient _dioClient;
  PaymentNegotiationService(this._dioClient);

  // ── Get by ID ──
  Future<PaymentNegotiation> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/paymentNegotiation/$id');
      return PaymentNegotiation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<PaymentNegotiation>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/paymentNegotiation', queryParameters: q);
      return (r.data['data'] as List).map((j) => PaymentNegotiation.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<PaymentNegotiation>> getWithFilters({
    PaymentNegotiationStatus? status,
    int? maxInstallments,
    double? minFirstPaymentPct,
    bool? platformValidated,
    String? validationNotes,
  }) async {
    final filters = <String, dynamic>{};
    if (status != null) filters['status'] = status.toString();
    if (maxInstallments != null) filters['maxInstallments'] = maxInstallments.toString();
    if (minFirstPaymentPct != null) filters['minFirstPaymentPct'] = minFirstPaymentPct.toString();
    if (platformValidated != null) filters['platformValidated'] = platformValidated.toString();
    if (validationNotes != null) filters['validationNotes'] = validationNotes;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<PaymentNegotiation> create(PaymentNegotiation paymentNegotiation) async {

    try {
      final r = await _dioClient.post('/paymentNegotiation', data: paymentNegotiation.toJson());
      return PaymentNegotiation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<PaymentNegotiation> update(String id, PaymentNegotiation paymentNegotiation) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/paymentNegotiation/$id', data: paymentNegotiation.toJson());
      return PaymentNegotiation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/paymentNegotiation/$id');
    } on DioException catch (e) { throw _err(e); }
  }

  Exception _err(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return Exception('Connection timeout. Check your internet connection.');
      case DioExceptionType.badResponse:
        final msg = e.response?.data?['message'] ?? 'Server error';
        return Exception('Server error: $msg');
      case DioExceptionType.connectionError:
        return Exception('Network error. Check your internet connection.');
      default:
        return Exception('Request failed: ${e.message}');
    }
  }
}