import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class LedgerEntryService {
  final DioClient _dioClient;
  LedgerEntryService(this._dioClient);

  Future<LedgerEntry> getLedgerEntryById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.ledgerEntries}/$id');
    return LedgerEntry.fromJson(response.data['data']);
  }

  Future<List<LedgerEntry>> getLedgerEntries({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.ledgerEntries, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => LedgerEntry.fromJson(json)).toList();
  }

  Future<LedgerEntry> createLedgerEntry(LedgerEntry item) async {
    final response = await _dioClient.post(ApiEndpoints.ledgerEntries, data: item.toJson());
    return LedgerEntry.fromJson(response.data['data']);
  }

  Future<LedgerEntry> updateLedgerEntry(String id, LedgerEntry item) async {
    final response = await _dioClient.patch('${ApiEndpoints.ledgerEntries}/$id', data: item.toJson());
    return LedgerEntry.fromJson(response.data['data']);
  }

  Future<void> deleteLedgerEntry(String id) async {
    await _dioClient.delete('${ApiEndpoints.ledgerEntries}/$id');
  }
}
