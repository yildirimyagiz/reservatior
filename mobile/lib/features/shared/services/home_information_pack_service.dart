import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class HomeInformationPackService {
  final DioClient _dioClient;
  HomeInformationPackService(this._dioClient);

  // ── Get by ID ──
  Future<HomeInformationPack> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/homeInformationPack/$id');
      return HomeInformationPack.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<HomeInformationPack>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/homeInformationPack', queryParameters: q);
      return (r.data['data'] as List).map((j) => HomeInformationPack.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<HomeInformationPack>> getWithFilters({
    String? title,
    String? description,
    String? fileUrl,
    String? fileName,
    int? fileSize,
  }) async {
    final filters = <String, dynamic>{};
    if (title != null) filters['title'] = title;
    if (description != null) filters['description'] = description;
    if (fileUrl != null) filters['fileUrl'] = fileUrl;
    if (fileName != null) filters['fileName'] = fileName;
    if (fileSize != null) filters['fileSize'] = fileSize.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<HomeInformationPack> create(HomeInformationPack homeInformationPack) async {
    if (homeInformationPack.title == null || homeInformationPack.title!.isEmpty) {
      throw ArgumentError('title is required');
    }
    try {
      final r = await _dioClient.post('/homeInformationPack', data: homeInformationPack.toJson());
      return HomeInformationPack.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<HomeInformationPack> update(String id, HomeInformationPack homeInformationPack) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/homeInformationPack/$id', data: homeInformationPack.toJson());
      return HomeInformationPack.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/homeInformationPack/$id');
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