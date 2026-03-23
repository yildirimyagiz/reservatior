import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class MarketingCampaignService {
  final DioClient _dioClient;
  MarketingCampaignService(this._dioClient);

  // ── Get by ID ──
  Future<MarketingCampaign> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/marketingCampaign/$id');
      return MarketingCampaign.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<MarketingCampaign>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/marketingCampaign', queryParameters: q);
      return (r.data['data'] as List).map((j) => MarketingCampaign.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<MarketingCampaign>> getWithFilters({
    String? name,
    CampaignType? type,
    CampaignStatus? status,
    String? targetType,
    String? subject,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (type != null) filters['type'] = type.toString();
    if (status != null) filters['status'] = status.toString();
    if (targetType != null) filters['targetType'] = targetType;
    if (subject != null) filters['subject'] = subject;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<MarketingCampaign> create(MarketingCampaign marketingCampaign) async {
    if (marketingCampaign.name == null || marketingCampaign.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    if (marketingCampaign.type == null || marketingCampaign.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    if (marketingCampaign.subject == null || marketingCampaign.subject!.isEmpty) {
      throw ArgumentError('subject is required');
    }
    try {
      final r = await _dioClient.post('/marketingCampaign', data: marketingCampaign.toJson());
      return MarketingCampaign.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<MarketingCampaign> update(String id, MarketingCampaign marketingCampaign) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/marketingCampaign/$id', data: marketingCampaign.toJson());
      return MarketingCampaign.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/marketingCampaign/$id');
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