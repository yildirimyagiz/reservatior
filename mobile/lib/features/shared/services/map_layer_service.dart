import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class MapLayerService {
  final DioClient _dioClient;
  MapLayerService(this._dioClient);

  // ── Get by ID ──
  Future<MapLayer> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/mapLayer/$id');
      return MapLayer.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<MapLayer>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/mapLayer', queryParameters: q);
      return (r.data['data'] as List).map((j) => MapLayer.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<MapLayer>> getWithFilters({
    String? name,
    String? type,
    MapProvider? provider,
    String? url,
    dynamic? config,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (type != null) filters['type'] = type;
    if (provider != null) filters['provider'] = provider.toString();
    if (url != null) filters['url'] = url;
    if (config != null) filters['config'] = config.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<MapLayer> create(MapLayer mapLayer) async {
    if (mapLayer.name == null || mapLayer.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    if (mapLayer.type == null || mapLayer.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    try {
      final r = await _dioClient.post('/mapLayer', data: mapLayer.toJson());
      return MapLayer.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<MapLayer> update(String id, MapLayer mapLayer) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/mapLayer/$id', data: mapLayer.toJson());
      return MapLayer.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/mapLayer/$id');
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