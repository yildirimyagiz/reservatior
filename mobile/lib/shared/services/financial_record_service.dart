import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class FinancialRecordService {
  final DioClient _dioClient;
  FinancialRecordService(this._dioClient);

  Future<FinancialRecord> getFinancialRecordById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.financialRecords}/$id');
    return FinancialRecord.fromJson(response.data['data']);
  }

  Future<List<FinancialRecord>> getFinancialRecords({
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
    final response = await _dioClient.get(ApiEndpoints.financialRecords, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => FinancialRecord.fromJson(json)).toList();
  }

  Future<FinancialRecord> createFinancialRecord(FinancialRecord item) async {
    final response = await _dioClient.post(ApiEndpoints.financialRecords, data: item.toJson());
    return FinancialRecord.fromJson(response.data['data']);
  }

  Future<FinancialRecord> updateFinancialRecord(String id, FinancialRecord item) async {
    final response = await _dioClient.patch('${ApiEndpoints.financialRecords}/$id', data: item.toJson());
    return FinancialRecord.fromJson(response.data['data']);
  }

  Future<void> deleteFinancialRecord(String id) async {
    await _dioClient.delete('${ApiEndpoints.financialRecords}/$id');
  }
}
