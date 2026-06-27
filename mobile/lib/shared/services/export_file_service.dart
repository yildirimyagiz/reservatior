import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ExportFileService {
  final DioClient _dioClient;
  ExportFileService(this._dioClient);

  Future<ExportFile> getExportFileById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.exportFiles}/$id');
    return ExportFile.fromJson(response.data['data']);
  }

  Future<List<ExportFile>> getExportFiles({
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
    final response = await _dioClient.get(ApiEndpoints.exportFiles, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ExportFile.fromJson(json)).toList();
  }

  Future<ExportFile> createExportFile(ExportFile item) async {
    final response = await _dioClient.post(ApiEndpoints.exportFiles, data: item.toJson());
    return ExportFile.fromJson(response.data['data']);
  }

  Future<ExportFile> updateExportFile(String id, ExportFile item) async {
    final response = await _dioClient.patch('${ApiEndpoints.exportFiles}/$id', data: item.toJson());
    return ExportFile.fromJson(response.data['data']);
  }

  Future<void> deleteExportFile(String id) async {
    await _dioClient.delete('${ApiEndpoints.exportFiles}/$id');
  }
}
