import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AttachmentService {
  final DioClient _dioClient;
  AttachmentService(this._dioClient);

  Future<Attachment> getAttachmentById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.attachments}/$id');
    return Attachment.fromJson(response.data['data']);
  }

  Future<List<Attachment>> getAttachments({
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
    final response = await _dioClient.get(ApiEndpoints.attachments, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Attachment.fromJson(json)).toList();
  }

  Future<Attachment> createAttachment(Attachment item) async {
    final response = await _dioClient.post(ApiEndpoints.attachments, data: item.toJson());
    return Attachment.fromJson(response.data['data']);
  }

  Future<Attachment> updateAttachment(String id, Attachment item) async {
    final response = await _dioClient.patch('${ApiEndpoints.attachments}/$id', data: item.toJson());
    return Attachment.fromJson(response.data['data']);
  }

  Future<void> deleteAttachment(String id) async {
    await _dioClient.delete('${ApiEndpoints.attachments}/$id');
  }
}
