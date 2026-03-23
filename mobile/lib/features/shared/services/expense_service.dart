import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../gen_models/models_library.dart';

class ExpenseService {
  final DioClient _dioClient;
  ExpenseService(this._dioClient);

  // ── Get by ID ──
  Future<Expense> getById(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.get('/expense/$id');
      return Expense.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get all ──
  Future<List<Expense>> getAll({
    int page = 1, int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final q = <String, dynamic>{'page': page.toString(), 'limit': limit.toString()};
      if (filters != null) q.addAll(filters);
      final r = await _dioClient.get('/expense', queryParameters: q);
      return (r.data['data'] as List).map((j) => Expense.fromJson(j)).toList();
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Get with filters ──
  Future<List<Expense>> getWithFilters({
    ExpenseType? type,
    double? amount,
    DateTime? dueDate,
    DateTime? paidDate,
    ExpenseStatus? status,
  }) async {
    final filters = <String, dynamic>{};
    if (type != null) filters['type'] = type.toString();
    if (amount != null) filters['amount'] = amount.toString();
    if (dueDate != null) filters['dueDate'] = dueDate.toIso8601String();
    if (paidDate != null) filters['paidDate'] = paidDate.toIso8601String();
    if (status != null) filters['status'] = status.toString();
    return getAll(filters: filters);
  }

  // ── Create ──
  Future<Expense> create(Expense expense) async {
    if (expense.type == null || expense.type!.isEmpty) {
      throw ArgumentError('type is required');
    }
    try {
      final r = await _dioClient.post('/expense', data: expense.toJson());
      return Expense.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Update ──
  Future<Expense> update(String id, Expense expense) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      final r = await _dioClient.put('/expense/$id', data: expense.toJson());
      return Expense.fromJson(r.data['data']);
    } on DioException catch (e) { throw _err(e); }
  }

  // ── Delete ──
  Future<void> delete(String id) async {
    if (id.isEmpty) throw ArgumentError('ID cannot be empty');
    try {
      await _dioClient.delete('/expense/$id');
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