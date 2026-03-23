import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AIPredictiveMaintenanceService {
  final DioClient _dioClient;
  AIPredictiveMaintenanceService(this._dioClient);

  // ── Get by ID ──
  Future<AIPredictiveMaintenance> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/aIPredictiveMaintenance/$id');
      return AIPredictiveMaintenance.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AIPredictiveMaintenance>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/aIPredictiveMaintenance', queryParameters: q);
      return (r.data['data'] as List).map((j) => AIPredictiveMaintenance.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AIPredictiveMaintenance>> getWithFilters({
    String? componentType,
    double? failureProbability,
    DateTime? predictedFailureDate,
    String? riskLevel,
    double? estimatedCost,
  }) async {
    final filters = <String, dynamic>{};
    if (componentType != null) filters['componentType'] = componentType;
    if (failureProbability != null) filters['failureProbability'] = failureProbability.toString();
    if (predictedFailureDate != null) filters['predictedFailureDate'] = predictedFailureDate.toIso8601String();
    if (riskLevel != null) filters['riskLevel'] = riskLevel;
    if (estimatedCost != null) filters['estimatedCost'] = estimatedCost.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AIPredictiveMaintenance> create(AIPredictiveMaintenance aiPredictiveMaintenance) async {

    try {
      final r = await _dioClient.post('/aIPredictiveMaintenance', data: aiPredictiveMaintenance.toJson());
      return AIPredictiveMaintenance.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AIPredictiveMaintenance> update(String id, AIPredictiveMaintenance aiPredictiveMaintenance) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/aIPredictiveMaintenance/$id', data: aiPredictiveMaintenance.toJson());
      return AIPredictiveMaintenance.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/aIPredictiveMaintenance/$id');
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