import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class MortgageOfferService {
  final DioClient _dioClient;
  MortgageOfferService(this._dioClient);

  // ── Get by ID ──
  Future<MortgageOffer> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/mortgageOffer/$id');
      return MortgageOffer.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<MortgageOffer>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/mortgageOffer', queryParameters: q);
      return (r.data['data'] as List).map((j) => MortgageOffer.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<MortgageOffer>> getWithFilters({
    String? lender,
    double? offerAmount,
    double? interestRate,
    int? termYears,
    double? monthlyPayment,
  }) async {
    final filters = <String, dynamic>{};
    if (lender != null) filters['lender'] = lender;
    if (offerAmount != null) filters['offerAmount'] = offerAmount.toString();
    if (interestRate != null) filters['interestRate'] = interestRate.toString();
    if (termYears != null) filters['termYears'] = termYears.toString();
    if (monthlyPayment != null) filters['monthlyPayment'] = monthlyPayment.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<MortgageOffer> create(MortgageOffer mortgageOffer) async {

    try {
      final r = await _dioClient.post('/mortgageOffer', data: mortgageOffer.toJson());
      return MortgageOffer.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<MortgageOffer> update(String id, MortgageOffer mortgageOffer) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/mortgageOffer/$id', data: mortgageOffer.toJson());
      return MortgageOffer.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/mortgageOffer/$id');
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