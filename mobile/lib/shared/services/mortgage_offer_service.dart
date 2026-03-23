import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MortgageOfferService {
  final DioClient _dioClient;

  MortgageOfferService(this._dioClient);

  // Get MortgageOffer by ID
  Future<MortgageOffer> getMortgageOfferById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/mortgage_offer/$id');
      return MortgageOffer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all mortgage_offers
  Future<List<MortgageOffer>> getMortgageOffers({
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

      final response = await _dioClient.get('/api/v1/mortgage_offer', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MortgageOffer.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MortgageOffer
  Future<MortgageOffer> createMortgageOffer(MortgageOffer mortgageOffer) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/mortgage_offer',
        data: mortgageOffer.toJson(),
      );
      return MortgageOffer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MortgageOffer
  Future<MortgageOffer> updateMortgageOffer(String id, MortgageOffer mortgageOffer) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/mortgage_offer/$id',
        data: mortgageOffer.toJson(),
      );
      return MortgageOffer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MortgageOffer
  Future<void> deleteMortgageOffer(String id) async {
    try {
      await _dioClient.delete('/api/v1/mortgage_offer/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
