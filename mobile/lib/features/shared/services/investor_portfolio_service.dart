import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class InvestorPortfolioService {
  final DioClient _dioClient;
  InvestorPortfolioService(this._dioClient);

  // ── Get by ID ──
  Future<InvestorPortfolio> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/investorPortfolio/$id');
      return InvestorPortfolio.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<InvestorPortfolio>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/investorPortfolio', queryParameters: q);
      return (r.data['data'] as List).map((j) => InvestorPortfolio.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<InvestorPortfolio>> getWithFilters({
    String? name,
    double? targetIrr,
    RiskTolerance? riskTolerance,
    String? investmentHorizon,
    double? totalInvested,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (targetIrr != null) filters['targetIrr'] = targetIrr.toString();
    if (riskTolerance != null) filters['riskTolerance'] = riskTolerance.toString();
    if (investmentHorizon != null) filters['investmentHorizon'] = investmentHorizon;
    if (totalInvested != null) filters['totalInvested'] = totalInvested.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<InvestorPortfolio> create(InvestorPortfolio investorPortfolio) async {
    if (investorPortfolio.name == null || investorPortfolio.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    try {
      final r = await _dioClient.post('/investorPortfolio', data: investorPortfolio.toJson());
      return InvestorPortfolio.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<InvestorPortfolio> update(String id, InvestorPortfolio investorPortfolio) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/investorPortfolio/$id', data: investorPortfolio.toJson());
      return InvestorPortfolio.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/investorPortfolio/$id');
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