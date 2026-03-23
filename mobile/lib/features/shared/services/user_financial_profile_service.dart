import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class UserFinancialProfileService {
  final DioClient _dioClient;
  UserFinancialProfileService(this._dioClient);

  // ── Get by ID ──
  Future<UserFinancialProfile> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/userFinancialProfile/$id');
      return UserFinancialProfile.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<UserFinancialProfile>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/userFinancialProfile', queryParameters: q);
      return (r.data['data'] as List).map((j) => UserFinancialProfile.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<UserFinancialProfile>> getWithFilters({
    Region? region,
    String? currency,
    double? monthlyIncome,
    double? monthlyObligations,
    RiskTolerance? riskTolerance,
  }) async {
    final filters = <String, dynamic>{};
    if (region != null) filters['region'] = region.toString();
    if (currency != null) filters['currency'] = currency;
    if (monthlyIncome != null) filters['monthlyIncome'] = monthlyIncome.toString();
    if (monthlyObligations != null) filters['monthlyObligations'] = monthlyObligations.toString();
    if (riskTolerance != null) filters['riskTolerance'] = riskTolerance.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<UserFinancialProfile> create(UserFinancialProfile userFinancialProfile) async {

    try {
      final r = await _dioClient.post('/userFinancialProfile', data: userFinancialProfile.toJson());
      return UserFinancialProfile.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<UserFinancialProfile> update(String id, UserFinancialProfile userFinancialProfile) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/userFinancialProfile/$id', data: userFinancialProfile.toJson());
      return UserFinancialProfile.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/userFinancialProfile/$id');
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