import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for NegotiationOffer operations
/// Provides CRUD operations with proper error handling and type safety
class NegotiationOfferRepository {
  final DioClient _dioClient;

  NegotiationOfferRepository(this._dioClient);

  /// Get NegotiationOffer by ID
  /// Returns [NegotiationOffer] if found, throws [RepositoryException] otherwise
  Future<NegotiationOffer> getNegotiationOfferById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/negotiation_offer/$id');
      if (response.statusCode == 200) {
        return NegotiationOffer.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch negotiation_offer',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all negotiation_offers with pagination and filtering
  /// Returns list of [NegotiationOffer] objects
  Future<List<NegotiationOffer>> getnegotiation_offers({
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
      
      final response = await _dioClient.get('/api/v1/negotiation_offer', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => NegotiationOffer.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch negotiation_offers',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new NegotiationOffer
  /// Returns created [NegotiationOffer] object
  Future<NegotiationOffer> createNegotiationOffer(NegotiationOffer negotiationOffer) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/negotiation_offer',
        data: negotiationOffer.toJson(),
      );
      return NegotiationOffer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update NegotiationOffer
  Future<NegotiationOffer> updateNegotiationOffer(String id, NegotiationOffer negotiationOffer) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/negotiation_offer/$id',
        data: negotiationOffer.toJson(),
      );
      return NegotiationOffer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete NegotiationOffer
  Future<void> deleteNegotiationOffer(String id) async {
    try {
      await _dioClient.delete('/api/v1/negotiation_offer/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
