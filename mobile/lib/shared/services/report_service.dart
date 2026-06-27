import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ReportService {
  final DioClient _dioClient;
  ReportService(this._dioClient);

  Future<Report> getReportById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.reports}/$id');
    return Report.fromJson(response.data['data']);
  }

  Future<List<Report>> getReports({
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
    final response = await _dioClient.get(ApiEndpoints.reports, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Report.fromJson(json)).toList();
  }

  Future<Report> createReport(Report item) async {
    final response = await _dioClient.post(ApiEndpoints.reports, data: item.toJson());
    return Report.fromJson(response.data['data']);
  }

  Future<Report> updateReport(String id, Report item) async {
    final response = await _dioClient.patch('${ApiEndpoints.reports}/$id', data: item.toJson());
    return Report.fromJson(response.data['data']);
  }

  Future<void> deleteReport(String id) async {
    await _dioClient.delete('${ApiEndpoints.reports}/$id');
  }
}
