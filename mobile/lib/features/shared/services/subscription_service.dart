import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class SubscriptionService {
  final DioClient _dioClient;
  SubscriptionService(this._dioClient);

  // ── Get by ID ──
  Future<Subscription> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/subscription/$id');
      return Subscription.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Subscription>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/subscription', queryParameters: q);
      return (r.data['data'] as List).map((j) => Subscription.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Subscription>> getWithFilters({
    String? name,
    MembershipType? type,
    double? price,
    String? currency,
    String? billingCycle,
  }) async {
    final filters = <String, dynamic>{};
    if (name != null) filters['name'] = name;
    if (type != null) filters['type'] = type.toString();
    if (price != null) filters['price'] = price.toString();
    if (currency != null) filters['currency'] = currency;
    if (billingCycle != null) filters['billingCycle'] = billingCycle;
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Subscription> create(Subscription subscription) async {
    if (subscription.name == null || subscription.name!.isEmpty) {
      throw ArgumentError('name is required');
    }
    if (subscription.type == null || subscription.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    try {
      final r = await _dioClient.post('/subscription', data: subscription.toJson());
      return Subscription.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Subscription> update(String id, Subscription subscription) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/subscription/$id', data: subscription.toJson());
      return Subscription.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/subscription/$id');
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