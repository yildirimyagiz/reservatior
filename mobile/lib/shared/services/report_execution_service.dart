import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ReportExecutionService {
  final DioClient _dioClient;
  ReportExecutionService(this._dioClient);

  Future<ReportExecution> getReportExecutionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.reportExecutions}/$id');
    return ReportExecution.fromJson(response.data['data']);
  }

  Future<List<ReportExecution>> getReportExecutions({
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
    final response = await _dioClient.get(ApiEndpoints.reportExecutions, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ReportExecution.fromJson(json)).toList();
  }

  Future<ReportExecution> createReportExecution(ReportExecution item) async {
    final response = await _dioClient.post(ApiEndpoints.reportExecutions, data: item.toJson());
    return ReportExecution.fromJson(response.data['data']);
  }

  Future<ReportExecution> updateReportExecution(String id, ReportExecution item) async {
    final response = await _dioClient.patch('${ApiEndpoints.reportExecutions}/$id', data: item.toJson());
    return ReportExecution.fromJson(response.data['data']);
  }

  Future<void> deleteReportExecution(String id) async {
    await _dioClient.delete('${ApiEndpoints.reportExecutions}/$id');
  }
}
