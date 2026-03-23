import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for AmbassadorCampaign operations
/// Provides CRUD operations with proper error handling and type safety
class AmbassadorCampaignRepository {
  final DioClient _dioClient;

  AmbassadorCampaignRepository(this._dioClient);

  /// Get AmbassadorCampaign by ID
  /// Returns [AmbassadorCampaign] if found, throws [RepositoryException] otherwise
  Future<AmbassadorCampaign> getAmbassadorCampaignById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ambassador_campaign/$id');
      if (response.statusCode == 200) {
        return AmbassadorCampaign.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ambassador_campaign',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all ambassador_campaigns with pagination and filtering
  /// Returns list of [AmbassadorCampaign] objects
  Future<List<AmbassadorCampaign>> getambassador_campaigns({
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
      
      final response = await _dioClient.get('/api/v1/ambassador_campaign', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => AmbassadorCampaign.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch ambassador_campaigns',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new AmbassadorCampaign
  /// Returns created [AmbassadorCampaign] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
