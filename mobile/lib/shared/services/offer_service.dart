import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class OfferService {
  final DioClient _dioClient;

  OfferService(this._dioClient);

  // Get Offer by ID
  Future<Offer> getOfferById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/offer/$id');
      return Offer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all offers
  Future<List<Offer>> getOffers({
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

      final response = await _dioClient.get('/api/v1/offer', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Offer.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Offer
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
    return Exception('API Error: ${e.message}');
  }
}
