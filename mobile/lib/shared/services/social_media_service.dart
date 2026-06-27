import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';

class SocialMediaService {
  final DioClient _dioClient;

  SocialMediaService(this._dioClient);

  Future<void> linkAccount(String platform, String accessToken) async {
    await _dioClient.post('${ApiEndpoints.apiIntegrations}/social/link', data: {
      'platform': platform,
      'accessToken': accessToken,
    });
  }

  Future<void> postToSocial(String platform, Map<String, dynamic> content) async {
    await _dioClient.post('${ApiEndpoints.apiIntegrations}/social/post', data: {
      'platform': platform,
      'content': content,
    });
  }

  Future<void> unlinkAccount(String platform) async {
    await _dioClient.delete('${ApiEndpoints.apiIntegrations}/social/unlink/$platform');
  }

  Future<List<Map<String, dynamic>>> getConnectedAccounts() async {
    final response = await _dioClient.get('${ApiEndpoints.apiIntegrations}/social/accounts');
    return List<Map<String, dynamic>>.from(response.data['data']);
  }
}
