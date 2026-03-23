import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class ContractVersionService {
  final DioClient _dioClient;
  ContractVersionService(this._dioClient);

  // ── Get by ID ──
  Future<ContractVersion> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/contractVersion/$id');
      return ContractVersion.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<ContractVersion>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/contractVersion', queryParameters: q);
      return (r.data['data'] as List).map((j) => ContractVersion.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<ContractVersion>> getWithFilters({
    int? version,
    String? documentUrl,
    String? checksum,
  }) async {
    final filters = <String, dynamic>{};
    if (version != null) filters['version'] = version.toString();
    if (documentUrl != null) filters['documentUrl'] = documentUrl;
    if (checksum != null) filters['checksum'] = checksum;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<ContractVersion> create(ContractVersion contractVersion) async {

    try {
      final r = await _dioClient.post('/contractVersion', data: contractVersion.toJson());
      return ContractVersion.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<ContractVersion> update(String id, ContractVersion contractVersion) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/contractVersion/$id', data: contractVersion.toJson());
      return ContractVersion.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/contractVersion/$id');
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