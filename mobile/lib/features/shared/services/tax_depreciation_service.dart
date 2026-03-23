import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class TaxDepreciationService {
  final DioClient _dioClient;
  TaxDepreciationService(this._dioClient);

  // ── Get by ID ──
  Future<TaxDepreciation> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/taxDepreciation/$id');
      return TaxDepreciation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<TaxDepreciation>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/taxDepreciation', queryParameters: q);
      return (r.data['data'] as List).map((j) => TaxDepreciation.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<TaxDepreciation>> getWithFilters({
    AssetType? assetType,
    double? costBasis,
    DepreciationMethod? depreciationMethod,
    int? usefulLife,
    double? salvageValue,
  }) async {
    final filters = <String, dynamic>{};
    if (assetType != null) filters['assetType'] = assetType.toString();
    if (costBasis != null) filters['costBasis'] = costBasis.toString();
    if (depreciationMethod != null) filters['depreciationMethod'] = depreciationMethod.toString();
    if (usefulLife != null) filters['usefulLife'] = usefulLife.toString();
    if (salvageValue != null) filters['salvageValue'] = salvageValue.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<TaxDepreciation> create(TaxDepreciation taxDepreciation) async {

    try {
      final r = await _dioClient.post('/taxDepreciation', data: taxDepreciation.toJson());
      return TaxDepreciation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<TaxDepreciation> update(String id, TaxDepreciation taxDepreciation) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/taxDepreciation/$id', data: taxDepreciation.toJson());
      return TaxDepreciation.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/taxDepreciation/$id');
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