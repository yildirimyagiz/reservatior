import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class GuestService {
  final DioClient _dioClient;
  GuestService(this._dioClient);

  // ── Get by ID ──
  Future<Guest> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/guest/$id');
      return Guest.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Guest>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/guest', queryParameters: q);
      return (r.data['data'] as List).map((j) => Guest.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Guest>> getWithFilters({
    String? name,
    String? phone,
    String? image,
    String? nationality,
    String? passportNumber,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (phone != null) filters['phone'] = phone;
    if (image != null) filters['image'] = image;
    if (nationality != null) filters['nationality'] = nationality;
    if (passportNumber != null) filters['passportNumber'] = passportNumber;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Guest> create(Guest guest) async {
    if (guest.name == null || guest.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    if (guest.email == null || guest.email!.isEmpty) {
      throw ArgumentError('email is required');
    }
    try {
      final r = await _dioClient.post('/guest', data: guest.toJson());
      return Guest.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Guest> update(String id, Guest guest) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/guest/$id', data: guest.toJson());
      return Guest.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/guest/$id');
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