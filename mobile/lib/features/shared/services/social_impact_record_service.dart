import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class SocialImpactRecordService {
  final DioClient _dioClient;
  SocialImpactRecordService(this._dioClient);

  // ── Get by ID ──
  Future<SocialImpactRecord> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/socialImpactRecord/$id');
      return SocialImpactRecord.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<SocialImpactRecord>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/socialImpactRecord', queryParameters: q);
      return (r.data['data'] as List).map((j) => SocialImpactRecord.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<SocialImpactRecord>> getWithFilters({
    SocialImpactType? impactType,
    int? quantity,
    double? amount,
    String? currency,
    String? description,
  }) async {
    final filters = <String, dynamic>{};
    if (impactType != null) filters['impactType'] = impactType.toString();
    if (quantity != null) filters['quantity'] = quantity.toString();
    if (amount != null) filters['amount'] = amount.toString();
    if (currency != null) filters['currency'] = currency;
    if (description != null) filters['description'] = description;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<SocialImpactRecord> create(SocialImpactRecord socialImpactRecord) async {

    try {
      final r = await _dioClient.post('/socialImpactRecord', data: socialImpactRecord.toJson());
      return SocialImpactRecord.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<SocialImpactRecord> update(String id, SocialImpactRecord socialImpactRecord) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/socialImpactRecord/$id', data: socialImpactRecord.toJson());
      return SocialImpactRecord.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/socialImpactRecord/$id');
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