import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ExportJobService {
  final DioClient _dioClient;
  ExportJobService(this._dioClient);

  Future<ExportJob> getExportJobById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.exportJobs}/$id');
    return ExportJob.fromJson(response.data['data']);
  }

  Future<List<ExportJob>> getExportJobs({
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
    final response = await _dioClient.get(ApiEndpoints.exportJobs, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ExportJob.fromJson(json)).toList();
  }

  Future<ExportJob> createExportJob(ExportJob item) async {
    final response = await _dioClient.post(ApiEndpoints.exportJobs, data: item.toJson());
    return ExportJob.fromJson(response.data['data']);
  }

  Future<ExportJob> updateExportJob(String id, ExportJob item) async {
    final response = await _dioClient.patch('${ApiEndpoints.exportJobs}/$id', data: item.toJson());
    return ExportJob.fromJson(response.data['data']);
  }

  Future<void> deleteExportJob(String id) async {
    await _dioClient.delete('${ApiEndpoints.exportJobs}/$id');
  }
}
