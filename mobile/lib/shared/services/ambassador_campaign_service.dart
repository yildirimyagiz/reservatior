import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AmbassadorCampaignService {
  final DioClient _dioClient;

  AmbassadorCampaignService(this._dioClient);

  // Get AmbassadorCampaign by ID
  Future<AmbassadorCampaign> getAmbassadorCampaignById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ambassador_campaign/$id');
      return AmbassadorCampaign.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ambassador_campaigns
  Future<List<AmbassadorCampaign>> getAmbassadorCampaigns({
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

      final response = await _dioClient.get('/api/v1/ambassador_campaign', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AmbassadorCampaign.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AmbassadorCampaign
  Future<AmbassadorCampaign> createAmbassadorCampaign(AmbassadorCampaign ambassadorCampaign) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ambassador_campaign',
        data: ambassadorCampaign.toJson(),
      );
      return AmbassadorCampaign.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AmbassadorCampaign
  Future<AmbassadorCampaign> updateAmbassadorCampaign(String id, AmbassadorCampaign ambassadorCampaign) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ambassador_campaign/$id',
        data: ambassadorCampaign.toJson(),
      );
      return AmbassadorCampaign.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AmbassadorCampaign
  Future<void> deleteAmbassadorCampaign(String id) async {
    try {
      await _dioClient.delete('/api/v1/ambassador_campaign/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
