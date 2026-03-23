import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class InvestorPropertyService {
  final DioClient _dioClient;
  InvestorPropertyService(this._dioClient);

  // ── Get by ID ──
  Future<InvestorProperty> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/investorProperty/$id');
      return InvestorProperty.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<InvestorProperty>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/investorProperty', queryParameters: q);
      return (r.data['data'] as List).map((j) => InvestorProperty.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<InvestorProperty>> getWithFilters({
    DateTime? acquiredAt,
    double? acquiredCost,
    double? mortgageBalance,
    double? mortgageRate,
    int? mortgageTerm,
  }) async {
    final filters = <String, dynamic>{};
    if (acquiredAt != null) filters['acquiredAt'] = acquiredAt.toIso8601String();
    if (acquiredCost != null) filters['acquiredCost'] = acquiredCost.toString();
    if (mortgageBalance != null) filters['mortgageBalance'] = mortgageBalance.toString();
    if (mortgageRate != null) filters['mortgageRate'] = mortgageRate.toString();
    if (mortgageTerm != null) filters['mortgageTerm'] = mortgageTerm.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<InvestorProperty> create(InvestorProperty investorProperty) async {

    try {
      final r = await _dioClient.post('/investorProperty', data: investorProperty.toJson());
      return InvestorProperty.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<InvestorProperty> update(String id, InvestorProperty investorProperty) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/investorProperty/$id', data: investorProperty.toJson());
      return InvestorProperty.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/investorProperty/$id');
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