import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AmbassadorContractService {
  final DioClient _dioClient;

  AmbassadorContractService(this._dioClient);

  // Get AmbassadorContract by ID
  Future<AmbassadorContract> getAmbassadorContractById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ambassador_contract/$id');
      return AmbassadorContract.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ambassador_contracts
  Future<List<AmbassadorContract>> getAmbassadorContracts({
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

      final response = await _dioClient.get('/api/v1/ambassador_contract', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AmbassadorContract.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AmbassadorContract
  Future<AmbassadorContract> createAmbassadorContract(AmbassadorContract ambassadorContract) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ambassador_contract',
        data: ambassadorContract.toJson(),
      );
      return AmbassadorContract.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AmbassadorContract
  Future<AmbassadorContract> updateAmbassadorContract(String id, AmbassadorContract ambassadorContract) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ambassador_contract/$id',
        data: ambassadorContract.toJson(),
      );
      return AmbassadorContract.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AmbassadorContract
  Future<void> deleteAmbassadorContract(String id) async {
    try {
      await _dioClient.delete('/api/v1/ambassador_contract/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
