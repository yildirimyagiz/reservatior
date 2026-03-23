import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class MlsDataMappingService {
  final DioClient _dioClient;
  MlsDataMappingService(this._dioClient);

  // ── Get by ID ──
  Future<MlsDataMapping> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/mlsDataMapping/$id');
      return MlsDataMapping.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<MlsDataMapping>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/mlsDataMapping', queryParameters: q);
      return (r.data['data'] as List).map((j) => MlsDataMapping.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<MlsDataMapping>> getWithFilters({
    MLSProviderKey? mlsProvider,
    String? fieldName,
    String? standardField,
    String? dataType,
    bool? isRequired,
  }) async {
    final filters = <String, dynamic>{};
    if (mlsProvider != null) filters['mlsProvider'] = mlsProvider.toString();
    if (fieldName != null) filters['fieldName'] = fieldName;
    if (standardField != null) filters['standardField'] = standardField;
    if (dataType != null) filters['dataType'] = dataType;
    if (isRequired != null) filters['isRequired'] = isRequired.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<MlsDataMapping> create(MlsDataMapping mlsDataMapping) async {

    try {
      final r = await _dioClient.post('/mlsDataMapping', data: mlsDataMapping.toJson());
      return MlsDataMapping.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<MlsDataMapping> update(String id, MlsDataMapping mlsDataMapping) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/mlsDataMapping/$id', data: mlsDataMapping.toJson());
      return MlsDataMapping.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/mlsDataMapping/$id');
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