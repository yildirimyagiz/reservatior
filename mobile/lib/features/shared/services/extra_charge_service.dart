import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class ExtraChargeService {
  final DioClient _dioClient;
  ExtraChargeService(this._dioClient);

  // ── Get by ID ──
  Future<ExtraCharge> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/extraCharge/$id');
      return ExtraCharge.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<ExtraCharge>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/extraCharge', queryParameters: q);
      return (r.data['data'] as List).map((j) => ExtraCharge.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<ExtraCharge>> getWithFilters({
    String? name,
    String? description,
    double? amount,
    String? chargeType,
    bool? isPaid,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (description != null) filters['description'] = description;
    if (amount != null) filters['amount'] = amount.toString();
    if (chargeType != null) filters['chargeType'] = chargeType;
    if (isPaid != null) filters['isPaid'] = isPaid.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<ExtraCharge> create(ExtraCharge extraCharge) async {
    if (extraCharge.name == null || extraCharge.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    try {
      final r = await _dioClient.post('/extraCharge', data: extraCharge.toJson());
      return ExtraCharge.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<ExtraCharge> update(String id, ExtraCharge extraCharge) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/extraCharge/$id', data: extraCharge.toJson());
      return ExtraCharge.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/extraCharge/$id');
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