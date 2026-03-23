import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class HomeInformationPackService {
  final DioClient _dioClient;

  HomeInformationPackService(this._dioClient);

  // Get HomeInformationPack by ID
  Future<HomeInformationPack> getHomeInformationPackById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/home_information_pack/$id');
      return HomeInformationPack.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all home_information_packs
  Future<List<HomeInformationPack>> getHomeInformationPacks({
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

      final response = await _dioClient.get('/api/v1/home_information_pack', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => HomeInformationPack.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create HomeInformationPack
  Future<HomeInformationPack> createHomeInformationPack(HomeInformationPack homeInformationPack) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/home_information_pack',
        data: homeInformationPack.toJson(),
      );
      return HomeInformationPack.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update HomeInformationPack
  Future<HomeInformationPack> updateHomeInformationPack(String id, HomeInformationPack homeInformationPack) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/home_information_pack/$id',
        data: homeInformationPack.toJson(),
      );
      return HomeInformationPack.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete HomeInformationPack
  Future<void> deleteHomeInformationPack(String id) async {
    try {
      await _dioClient.delete('/api/v1/home_information_pack/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
