import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class AgentService {
  final DioClient _dioClient;
  AgentService(this._dioClient);

  // ── Get by ID ──
  Future<Agent> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/agent/$id');
      return Agent.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Agent>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/agent', queryParameters: q);
      return (r.data['data'] as List).map((j) => Agent.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Agent>> getWithFilters({
    String? name,
    String? email,
    String? phoneNumber,
    String? bio,
    String? address,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (email != null) filters['email'] = email;
    if (phoneNumber != null) filters['phoneNumber'] = phoneNumber;
    if (bio != null) filters['bio'] = bio;
    if (address != null) filters['address'] = address;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Agent> create(Agent agent) async {
    if (agent.name == null || agent.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    if (agent.email == null || agent.email!.isEmpty) {
      throw ArgumentError('email is required');
    }
    try {
      final r = await _dioClient.post('/agent', data: agent.toJson());
      return Agent.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Agent> update(String id, Agent agent) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/agent/$id', data: agent.toJson());
      return Agent.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/agent/$id');
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