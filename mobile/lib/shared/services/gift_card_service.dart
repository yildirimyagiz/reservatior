import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class GiftCardService {
  final DioClient _dioClient;

  GiftCardService(this._dioClient);

  // Get GiftCard by ID
  Future<GiftCard> getGiftCardById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/gift_card/$id');
      return GiftCard.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all gift_cards
  Future<List<GiftCard>> getGiftCards({
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

      final response = await _dioClient.get('/api/v1/gift_card', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => GiftCard.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create GiftCard
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
    return Exception('API Error: ${e.message}');
  }
}
