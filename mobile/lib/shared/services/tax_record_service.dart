import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class TaxRecordService {
  final DioClient _dioClient;
  TaxRecordService(this._dioClient);

  Future<TaxRecord> getTaxRecordById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.taxRecords}/$id');
    return TaxRecord.fromJson(response.data['data']);
  }

  Future<List<TaxRecord>> getTaxRecords({
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
    final response = await _dioClient.get(ApiEndpoints.taxRecords, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => TaxRecord.fromJson(json)).toList();
  }

  Future<TaxRecord> createTaxRecord(TaxRecord item) async {
    final response = await _dioClient.post(ApiEndpoints.taxRecords, data: item.toJson());
    return TaxRecord.fromJson(response.data['data']);
  }

  Future<TaxRecord> updateTaxRecord(String id, TaxRecord item) async {
    final response = await _dioClient.patch('${ApiEndpoints.taxRecords}/$id', data: item.toJson());
    return TaxRecord.fromJson(response.data['data']);
  }

  Future<void> deleteTaxRecord(String id) async {
    await _dioClient.delete('${ApiEndpoints.taxRecords}/$id');
  }
}
