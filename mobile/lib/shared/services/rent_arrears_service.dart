import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class RentArrearsService {
  final DioClient _dioClient;

  RentArrearsService(this._dioClient);

  // Get RentArrears by ID
  Future<RentArrears> getRentArrearsById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/rent_arrears/$id');
      return RentArrears.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all rent_arrearss
  Future<List<RentArrears>> getRentArrearss({
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

      final response = await _dioClient.get('/api/v1/rent_arrears', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => RentArrears.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create RentArrears
  Future<RentArrears> createRentArrears(RentArrears rentArrears) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/rent_arrears',
        data: rentArrears.toJson(),
      );
      return RentArrears.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update RentArrears
  Future<RentArrears> updateRentArrears(String id, RentArrears rentArrears) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/rent_arrears/$id',
        data: rentArrears.toJson(),
      );
      return RentArrears.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete RentArrears
  Future<void> deleteRentArrears(String id) async {
    try {
      await _dioClient.delete('/api/v1/rent_arrears/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
