import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class NegotiationOfferService {
  final DioClient _dioClient;

  NegotiationOfferService(this._dioClient);

  // Get NegotiationOffer by ID
  Future<NegotiationOffer> getNegotiationOfferById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/negotiation_offer/$id');
      return NegotiationOffer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all negotiation_offers
  Future<List<NegotiationOffer>> getNegotiationOffers({
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

      final response = await _dioClient.get('/api/v1/negotiation_offer', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => NegotiationOffer.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create NegotiationOffer
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
    return Exception('API Error: ${e.message}');
  }
}
