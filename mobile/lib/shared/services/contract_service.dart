import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ContractService {
  final DioClient _dioClient;

  ContractService(this._dioClient);

  // Get Contract by ID
  Future<Contract> getContractById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/contract/$id');
      return Contract.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all contracts
  Future<List<Contract>> getContracts({
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

      final response = await _dioClient.get('/api/v1/contract', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Contract.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Contract
  Future<Contract> createContract(Contract contract) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/contract',
        data: contract.toJson(),
      );
      return Contract.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Contract
  Future<Contract> updateContract(String id, Contract contract) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/contract/$id',
        data: contract.toJson(),
      );
      return Contract.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Contract
  Future<void> deleteContract(String id) async {
    try {
      await _dioClient.delete('/api/v1/contract/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
