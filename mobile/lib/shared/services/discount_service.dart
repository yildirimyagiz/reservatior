import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class DiscountService {
  final DioClient _dioClient;

  DiscountService(this._dioClient);

  // Get Discount by ID
  Future<Discount> getDiscountById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/discount/$id');
      return Discount.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all discounts
  Future<List<Discount>> getDiscounts({
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

      final response = await _dioClient.get('/api/v1/discount', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Discount.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Discount
  Future<Discount> createDiscount(Discount discount) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/discount',
        data: discount.toJson(),
      );
      return Discount.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Discount
  Future<Discount> updateDiscount(String id, Discount discount) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/discount/$id',
        data: discount.toJson(),
      );
      return Discount.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Discount
  Future<void> deleteDiscount(String id) async {
    try {
      await _dioClient.delete('/api/v1/discount/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
