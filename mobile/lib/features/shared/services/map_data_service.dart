import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class MapDataService {
  final DioClient _dioClient;
  MapDataService(this._dioClient);

  // ── Get by ID ──
  Future<MapData> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/mapData/$id');
      return MapData.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<MapData>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/mapData', queryParameters: q);
      return (r.data['data'] as List).map((j) => MapData.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<MapData>> getWithFilters({
    dynamic? coordinates,
    String? address,
    dynamic? amenities,
    dynamic? geocodingData,
  }) async {
    final filters = <String, dynamic>{};
    if (coordinates != null) filters['coordinates'] = coordinates.toString();
    if (address != null) filters['address'] = address;
    if (amenities != null) filters['amenities'] = amenities.toString();
    if (geocodingData != null) filters['geocodingData'] = geocodingData.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<MapData> create(MapData mapData) async {

    try {
      final r = await _dioClient.post('/mapData', data: mapData.toJson());
      return MapData.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<MapData> update(String id, MapData mapData) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/mapData/$id', data: mapData.toJson());
      return MapData.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/mapData/$id');
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