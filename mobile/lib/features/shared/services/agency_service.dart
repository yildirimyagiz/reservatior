import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AgencyService {
  final DioClient _dioClient;
  AgencyService(this._dioClient);

  // ── Get by ID ──
  Future<Agency> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/agency/$id');
      return Agency.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Agency>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/agency', queryParameters: q);
      return (r.data['data'] as List).map((j) => Agency.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Agency>> getWithFilters({
    String? name,
    String? description,
    String? email,
    String? phoneNumber,
    String? address,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (description != null) filters['description'] = description;
    if (email != null) filters['email'] = email;
    if (phoneNumber != null) filters['phoneNumber'] = phoneNumber;
    if (address != null) filters['address'] = address;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Agency> create(Agency agency) async {
    if (agency.name == null || agency.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    if (agency.email == null || agency.email!.isEmpty) {
      throw ArgumentError('email is required');
    }
    try {
      final r = await _dioClient.post('/agency', data: agency.toJson());
      return Agency.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Agency> update(String id, Agency agency) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/agency/$id', data: agency.toJson());
      return Agency.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/agency/$id');
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