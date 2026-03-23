import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Offer operations
/// Provides CRUD operations with proper error handling and type safety
class OfferRepository {
  final DioClient _dioClient;

  OfferRepository(this._dioClient);

  /// Get Offer by ID
  /// Returns [Offer] if found, throws [RepositoryException] otherwise
  Future<Offer> getOfferById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/offer/$id');
      if (response.statusCode == 200) {
        return Offer.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch offer',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all offers with pagination and filtering
  /// Returns list of [Offer] objects
  Future<List<Offer>> getoffers({
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
      
      final response = await _dioClient.get('/api/v1/offer', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Offer.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch offers',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Offer
  /// Returns created [Offer] object
  Future<Offer> createOffer(Offer offer) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/offer',
        data: offer.toJson(),
      );
      return Offer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Offer
  Future<Offer> updateOffer(String id, Offer offer) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/offer/$id',
        data: offer.toJson(),
      );
      return Offer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Offer
  Future<void> deleteOffer(String id) async {
    try {
      await _dioClient.delete('/api/v1/offer/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
