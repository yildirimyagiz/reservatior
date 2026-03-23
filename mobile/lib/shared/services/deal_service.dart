import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class DealService {
  final DioClient _dioClient;

  DealService(this._dioClient);

  // Get Deal by ID
  Future<Deal> getDealById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/deal/$id');
      return Deal.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all deals
  Future<List<Deal>> getDeals({
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

      final response = await _dioClient.get('/api/v1/deal', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Deal.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Deal
  Future<Deal> createDeal(Deal deal) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/deal',
        data: deal.toJson(),
      );
      return Deal.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Deal
  Future<Deal> updateDeal(String id, Deal deal) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/deal/$id',
        data: deal.toJson(),
      );
      return Deal.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Deal
  Future<void> deleteDeal(String id) async {
    try {
      await _dioClient.delete('/api/v1/deal/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
