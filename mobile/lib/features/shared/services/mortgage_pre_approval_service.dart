import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class MortgagePreApprovalService {
  final DioClient _dioClient;
  MortgagePreApprovalService(this._dioClient);

  // ── Get by ID ──
  Future<MortgagePreApproval> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/mortgagePreApproval/$id');
      return MortgagePreApproval.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<MortgagePreApproval>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/mortgagePreApproval', queryParameters: q);
      return (r.data['data'] as List).map((j) => MortgagePreApproval.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<MortgagePreApproval>> getWithFilters({
    String? lenderName,
    String? mortgageType,
    int? mortgageTerm,
    double? interestRate,
    double? arrangementFee,
  }) async {
    final filters = <String, dynamic>{};
    if (lenderName != null) filters['lenderName'] = lenderName;
    if (mortgageType != null) filters['mortgageType'] = mortgageType;
    if (mortgageTerm != null) filters['mortgageTerm'] = mortgageTerm.toString();
    if (interestRate != null) filters['interestRate'] = interestRate.toString();
    if (arrangementFee != null) filters['arrangementFee'] = arrangementFee.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<MortgagePreApproval> create(MortgagePreApproval mortgagePreApproval) async {

    try {
      final r = await _dioClient.post('/mortgagePreApproval', data: mortgagePreApproval.toJson());
      return MortgagePreApproval.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<MortgagePreApproval> update(String id, MortgagePreApproval mortgagePreApproval) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/mortgagePreApproval/$id', data: mortgagePreApproval.toJson());
      return MortgagePreApproval.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/mortgagePreApproval/$id');
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