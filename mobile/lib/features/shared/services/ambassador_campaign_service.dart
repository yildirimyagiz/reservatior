import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AmbassadorCampaignService {
  final DioClient _dioClient;
  AmbassadorCampaignService(this._dioClient);

  // ── Get by ID ──
  Future<AmbassadorCampaign> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/ambassadorCampaign/$id');
      return AmbassadorCampaign.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<AmbassadorCampaign>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/ambassadorCampaign', queryParameters: q);
      return (r.data['data'] as List).map((j) => AmbassadorCampaign.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<AmbassadorCampaign>> getWithFilters({
    String? name,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    double? budget,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (description != null) filters['description'] = description;
    if (startDate != null) filters['startDate'] = startDate.toIso8601String();
    if (endDate != null) filters['endDate'] = endDate.toIso8601String();
    if (budget != null) filters['budget'] = budget.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<AmbassadorCampaign> create(AmbassadorCampaign ambassadorCampaign) async {
    if (ambassadorCampaign.name == null || ambassadorCampaign.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    try {
      final r = await _dioClient.post('/ambassadorCampaign', data: ambassadorCampaign.toJson());
      return AmbassadorCampaign.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<AmbassadorCampaign> update(String id, AmbassadorCampaign ambassadorCampaign) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/ambassadorCampaign/$id', data: ambassadorCampaign.toJson());
      return AmbassadorCampaign.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/ambassadorCampaign/$id');
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