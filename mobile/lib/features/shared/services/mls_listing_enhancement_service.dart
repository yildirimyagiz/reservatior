import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class MlsListingEnhancementService {
  final DioClient _dioClient;
  MlsListingEnhancementService(this._dioClient);

  // ── Get by ID ──
  Future<MlsListingEnhancement> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/mlsListingEnhancement/$id');
      return MlsListingEnhancement.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<MlsListingEnhancement>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/mlsListingEnhancement', queryParameters: q);
      return (r.data['data'] as List).map((j) => MlsListingEnhancement.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<MlsListingEnhancement>> getWithFilters({
    String? mlsNumber,
    String? mlsStatus,
    dynamic? mlsPhotos,
    dynamic? mlsDocuments,
    dynamic? mlsHistory,
  }) async {
    final filters = <String, dynamic>{};
    if (mlsNumber != null) filters['mlsNumber'] = mlsNumber;
    if (mlsStatus != null) filters['mlsStatus'] = mlsStatus;
    if (mlsPhotos != null) filters['mlsPhotos'] = mlsPhotos.toString();
    if (mlsDocuments != null) filters['mlsDocuments'] = mlsDocuments.toString();
    if (mlsHistory != null) filters['mlsHistory'] = mlsHistory.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<MlsListingEnhancement> create(MlsListingEnhancement mlsListingEnhancement) async {

    try {
      final r = await _dioClient.post('/mlsListingEnhancement', data: mlsListingEnhancement.toJson());
      return MlsListingEnhancement.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<MlsListingEnhancement> update(String id, MlsListingEnhancement mlsListingEnhancement) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/mlsListingEnhancement/$id', data: mlsListingEnhancement.toJson());
      return MlsListingEnhancement.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/mlsListingEnhancement/$id');
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