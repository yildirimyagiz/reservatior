import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for MarketingCampaign operations
/// Provides CRUD operations with proper error handling and type safety
class MarketingCampaignRepository {
  final DioClient _dioClient;

  MarketingCampaignRepository(this._dioClient);

  /// Get MarketingCampaign by ID
  /// Returns [MarketingCampaign] if found, throws [RepositoryException] otherwise
  Future<MarketingCampaign> getMarketingCampaignById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/marketing_campaign/$id');
      if (response.statusCode == 200) {
        return MarketingCampaign.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch marketing_campaign',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all marketing_campaigns with pagination and filtering
  /// Returns list of [MarketingCampaign] objects
  Future<List<MarketingCampaign>> getmarketing_campaigns({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/marketing_campaign', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => MarketingCampaign.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch marketing_campaigns',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new MarketingCampaign
  /// Returns created [MarketingCampaign] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
