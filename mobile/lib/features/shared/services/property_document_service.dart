import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class PropertyDocumentService {
  final DioClient _dioClient;
  PropertyDocumentService(this._dioClient);

  // ── Get by ID ──
  Future<PropertyDocument> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/propertyDocument/$id');
      return PropertyDocument.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<PropertyDocument>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/propertyDocument', queryParameters: q);
      return (r.data['data'] as List).map((j) => PropertyDocument.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<PropertyDocument>> getWithFilters({
    String? title,
    String? fileName,
    String? mimeType,
    int? sizeBytes,
    String? storageKey,
  }) async {
    final filters = <String, dynamic>{};
    if (title != null) filters['title'] = title;
    if (fileName != null) filters['fileName'] = fileName;
    if (mimeType != null) filters['mimeType'] = mimeType;
    if (sizeBytes != null) filters['sizeBytes'] = sizeBytes.toString();
    if (storageKey != null) filters['storageKey'] = storageKey;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<PropertyDocument> create(PropertyDocument propertyDocument) async {
    if (propertyDocument.title == null || propertyDocument.title!.isEmpty) {
      throw ArgumentError('title is required');
    }
    try {
      final r = await _dioClient.post('/propertyDocument', data: propertyDocument.toJson());
      return PropertyDocument.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<PropertyDocument> update(String id, PropertyDocument propertyDocument) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/propertyDocument/$id', data: propertyDocument.toJson());
      return PropertyDocument.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/propertyDocument/$id');
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