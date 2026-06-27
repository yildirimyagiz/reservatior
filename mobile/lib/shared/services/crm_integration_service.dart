import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';

class CrmIntegrationService {
  final DioClient _dioClient;

  CrmIntegrationService(this._dioClient);

  Future<void> syncLeads(String platform) async {
    await _dioClient.post('${ApiEndpoints.apiIntegrations}/crm/sync-leads', data: {
      'platform': platform,
    });
  }

  Future<void> exportToCrm(String platform, Map<String, dynamic> data) async {
    await _dioClient.post('${ApiEndpoints.apiIntegrations}/crm/export', data: {
      'platform': platform,
      'data': data,
    });
  }

  Future<Map<String, dynamic>> getSyncStatus(String platform) async {
    final response = await _dioClient.get('${ApiEndpoints.apiIntegrations}/crm/status/$platform');
    return Map<String, dynamic>.from(response.data['data']);
  }

  Future<void> updateSettings(String platform, Map<String, dynamic> settings) async {
    await _dioClient.patch('${ApiEndpoints.apiIntegrations}/crm/settings/$platform', data: settings);
  }
}
