import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AmbassadorCampaignService {
  final DioClient _dioClient;
  AmbassadorCampaignService(this._dioClient);

  Future<AmbassadorCampaign> getAmbassadorCampaignById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.ambassadorCampaigns}/$id');
    return AmbassadorCampaign.fromJson(response.data['data']);
  }

  Future<List<AmbassadorCampaign>> getAmbassadorCampaigns({
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
    final response = await _dioClient.get(ApiEndpoints.ambassadorCampaigns, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AmbassadorCampaign.fromJson(json)).toList();
  }

  Future<AmbassadorCampaign> createAmbassadorCampaign(AmbassadorCampaign item) async {
    final response = await _dioClient.post(ApiEndpoints.ambassadorCampaigns, data: item.toJson());
    return AmbassadorCampaign.fromJson(response.data['data']);
  }

  Future<AmbassadorCampaign> updateAmbassadorCampaign(String id, AmbassadorCampaign item) async {
    final response = await _dioClient.patch('${ApiEndpoints.ambassadorCampaigns}/$id', data: item.toJson());
    return AmbassadorCampaign.fromJson(response.data['data']);
  }

  Future<void> deleteAmbassadorCampaign(String id) async {
    await _dioClient.delete('${ApiEndpoints.ambassadorCampaigns}/$id');
  }
}
