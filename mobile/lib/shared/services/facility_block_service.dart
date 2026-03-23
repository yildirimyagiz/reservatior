import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class FacilityBlockService {
  final DioClient _dioClient;

  FacilityBlockService(this._dioClient);

  // Get FacilityBlock by ID
  Future<FacilityBlock> getFacilityBlockById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/facility_block/$id');
      return FacilityBlock.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all facility_blocks
  Future<List<FacilityBlock>> getFacilityBlocks({
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

      final response = await _dioClient.get('/api/v1/facility_block', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => FacilityBlock.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create FacilityBlock
  Future<FacilityBlock> createFacilityBlock(FacilityBlock facilityBlock) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/facility_block',
        data: facilityBlock.toJson(),
      );
      return FacilityBlock.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update FacilityBlock
  Future<FacilityBlock> updateFacilityBlock(String id, FacilityBlock facilityBlock) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/facility_block/$id',
        data: facilityBlock.toJson(),
      );
      return FacilityBlock.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete FacilityBlock
  Future<void> deleteFacilityBlock(String id) async {
    try {
      await _dioClient.delete('/api/v1/facility_block/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
