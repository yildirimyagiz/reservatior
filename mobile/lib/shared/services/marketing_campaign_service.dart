import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MarketingCampaignService {
  final DioClient _dioClient;

  MarketingCampaignService(this._dioClient);

  // Get MarketingCampaign by ID
  Future<MarketingCampaign> getMarketingCampaignById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/marketing_campaign/$id');
      return MarketingCampaign.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all marketing_campaigns
  Future<List<MarketingCampaign>> getMarketingCampaigns({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/marketing_campaign', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MarketingCampaign.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MarketingCampaign
  Future<MarketingCampaign> createMarketingCampaign(MarketingCampaign marketingCampaign) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/marketing_campaign',
        data: marketingCampaign.toJson(),
      );
      return MarketingCampaign.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MarketingCampaign
  Future<MarketingCampaign> updateMarketingCampaign(String id, MarketingCampaign marketingCampaign) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/marketing_campaign/$id',
        data: marketingCampaign.toJson(),
      );
      return MarketingCampaign.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MarketingCampaign
  Future<void> deleteMarketingCampaign(String id) async {
    try {
      await _dioClient.delete('/api/v1/marketing_campaign/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
