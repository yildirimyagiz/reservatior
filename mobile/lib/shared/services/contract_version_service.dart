import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ContractVersionService {
  final DioClient _dioClient;

  ContractVersionService(this._dioClient);

  // Get ContractVersion by ID
  Future<ContractVersion> getContractVersionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/contract_version/$id');
      return ContractVersion.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all contract_versions
  Future<List<ContractVersion>> getContractVersions({
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

      final response = await _dioClient.get('/api/v1/contract_version', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ContractVersion.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ContractVersion
  Future<ContractVersion> createContractVersion(ContractVersion contractVersion) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/contract_version',
        data: contractVersion.toJson(),
      );
      return ContractVersion.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ContractVersion
  Future<ContractVersion> updateContractVersion(String id, ContractVersion contractVersion) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/contract_version/$id',
        data: contractVersion.toJson(),
      );
      return ContractVersion.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ContractVersion
  Future<void> deleteContractVersion(String id) async {
    try {
      await _dioClient.delete('/api/v1/contract_version/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
