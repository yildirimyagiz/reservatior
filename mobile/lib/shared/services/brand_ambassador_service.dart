import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class BrandAmbassadorService {
  final DioClient _dioClient;

  BrandAmbassadorService(this._dioClient);

  // Get BrandAmbassador by ID
  Future<BrandAmbassador> getBrandAmbassadorById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/brand_ambassador/$id');
      return BrandAmbassador.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all brand_ambassadors
  Future<List<BrandAmbassador>> getBrandAmbassadors({
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

      final response = await _dioClient.get('/api/v1/brand_ambassador', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => BrandAmbassador.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create BrandAmbassador
  Future<BrandAmbassador> createBrandAmbassador(BrandAmbassador brandAmbassador) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/brand_ambassador',
        data: brandAmbassador.toJson(),
      );
      return BrandAmbassador.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update BrandAmbassador
  Future<BrandAmbassador> updateBrandAmbassador(String id, BrandAmbassador brandAmbassador) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/brand_ambassador/$id',
        data: brandAmbassador.toJson(),
      );
      return BrandAmbassador.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete BrandAmbassador
  Future<void> deleteBrandAmbassador(String id) async {
    try {
      await _dioClient.delete('/api/v1/brand_ambassador/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
