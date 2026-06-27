import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MarketingCampaignService {
  final DioClient _dioClient;
  MarketingCampaignService(this._dioClient);

  Future<MarketingCampaign> getMarketingCampaignById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.marketingCampaigns}/$id');
    return MarketingCampaign.fromJson(response.data['data']);
  }

  Future<List<MarketingCampaign>> getMarketingCampaigns({
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
    final response = await _dioClient.get(ApiEndpoints.marketingCampaigns, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => MarketingCampaign.fromJson(json)).toList();
  }

  Future<MarketingCampaign> createMarketingCampaign(MarketingCampaign item) async {
    final response = await _dioClient.post(ApiEndpoints.marketingCampaigns, data: item.toJson());
    return MarketingCampaign.fromJson(response.data['data']);
  }

  Future<MarketingCampaign> updateMarketingCampaign(String id, MarketingCampaign item) async {
    final response = await _dioClient.patch('${ApiEndpoints.marketingCampaigns}/$id', data: item.toJson());
    return MarketingCampaign.fromJson(response.data['data']);
  }

  Future<void> deleteMarketingCampaign(String id) async {
    await _dioClient.delete('${ApiEndpoints.marketingCampaigns}/$id');
  }
}
