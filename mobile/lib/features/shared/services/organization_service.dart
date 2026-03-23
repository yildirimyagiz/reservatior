import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class OrganizationService {
  final DioClient _dioClient;
  OrganizationService(this._dioClient);

  // ── Get by ID ──
  Future<Organization> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/organization/$id');
      return Organization.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Organization>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/organization', queryParameters: q);
      return (r.data['data'] as List).map((j) => Organization.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Organization>> getWithFilters({
    String? name,
    OrgType? type,
    Region? region,
    String? defaultCurrency,
    String? defaultLocale,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (type != null) filters['type'] = type.toString();
    if (region != null) filters['region'] = region.toString();
    if (defaultCurrency != null) filters['defaultCurrency'] = defaultCurrency;
    if (defaultLocale != null) filters['defaultLocale'] = defaultLocale;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Organization> create(Organization organization) async {
    if (organization.name == null || organization.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    if (organization.type == null || organization.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    try {
      final r = await _dioClient.post('/organization', data: organization.toJson());
      return Organization.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Organization> update(String id, Organization organization) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/organization/$id', data: organization.toJson());
      return Organization.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/organization/$id');
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