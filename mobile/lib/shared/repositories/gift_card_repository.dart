import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for GiftCard operations
/// Provides CRUD operations with proper error handling and type safety
class GiftCardRepository {
  final DioClient _dioClient;

  GiftCardRepository(this._dioClient);

  /// Get GiftCard by ID
  /// Returns [GiftCard] if found, throws [RepositoryException] otherwise
  Future<GiftCard> getGiftCardById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/gift_card/$id');
      if (response.statusCode == 200) {
        return GiftCard.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch gift_card',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all gift_cards with pagination and filtering
  /// Returns list of [GiftCard] objects
  Future<List<GiftCard>> getgift_cards({
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
      
      final response = await _dioClient.get('/api/v1/gift_card', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => GiftCard.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch gift_cards',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new GiftCard
  /// Returns created [GiftCard] object
  Future<GiftCard> createGiftCard(GiftCard giftCard) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/gift_card',
        data: giftCard.toJson(),
      );
      return GiftCard.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update GiftCard
  Future<GiftCard> updateGiftCard(String id, GiftCard giftCard) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/gift_card/$id',
        data: giftCard.toJson(),
      );
      return GiftCard.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete GiftCard
  Future<void> deleteGiftCard(String id) async {
    try {
      await _dioClient.delete('/api/v1/gift_card/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
