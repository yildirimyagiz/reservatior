import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class LedgerEntryService {
  final DioClient _dioClient;

  LedgerEntryService(this._dioClient);

  // Get LedgerEntry by ID
  Future<LedgerEntry> getLedgerEntryById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ledger_entry/$id');
      return LedgerEntry.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ledger_entrys
  Future<List<LedgerEntry>> getLedgerEntrys({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/ledger_entry', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => LedgerEntry.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create LedgerEntry
  Future<LedgerEntry> createLedgerEntry(LedgerEntry ledgerEntry) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ledger_entry',
        data: ledgerEntry.toJson(),
      );
      return LedgerEntry.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update LedgerEntry
  Future<LedgerEntry> updateLedgerEntry(String id, LedgerEntry ledgerEntry) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ledger_entry/$id',
        data: ledgerEntry.toJson(),
      );
      return LedgerEntry.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete LedgerEntry
  Future<void> deleteLedgerEntry(String id) async {
    try {
      await _dioClient.delete('/api/v1/ledger_entry/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
