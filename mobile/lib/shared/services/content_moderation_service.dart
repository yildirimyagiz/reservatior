import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';

class ContentModerationService {
  final DioClient _dioClient;

  ContentModerationService(this._dioClient);

  Future<List<Map<String, dynamic>>> getPendingContent() async {
    final response = await _dioClient.get('${ApiEndpoints.adminModeration}/pending');
    return List<Map<String, dynamic>>.from(response.data['data']);
  }

  Future<void> approveContent(String contentType, String contentId) async {
    await _dioClient.post('${ApiEndpoints.adminModeration}/approve', data: {
      'type': contentType,
      'id': contentId,
    });
  }

  Future<void> rejectContent(String contentType, String contentId, String reason) async {
    await _dioClient.post('${ApiEndpoints.adminModeration}/reject', data: {
      'type': contentType,
      'id': contentId,
      'reason': reason,
    });
  }

  Future<void> flagContent(String contentType, String contentId, String flagType) async {
    await _dioClient.post('${ApiEndpoints.adminModeration}/flag', data: {
      'type': contentType,
      'id': contentId,
      'flagType': flagType,
    });
  }

  Future<Map<String, dynamic>> getModerationStats() async {
    final response = await _dioClient.get('${ApiEndpoints.adminModeration}/stats');
    return Map<String, dynamic>.from(response.data['data']);
  }
}
