import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for ContractVersion operations
/// Provides CRUD operations with proper error handling and type safety
class ContractVersionRepository {
  final DioClient _dioClient;

  ContractVersionRepository(this._dioClient);

  /// Get ContractVersion by ID
  /// Returns [ContractVersion] if found, throws [RepositoryException] otherwise
  Future<ContractVersion> getContractVersionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/contract_version/$id');
      if (response.statusCode == 200) {
        return ContractVersion.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch contract_version',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all contract_versions with pagination and filtering
  /// Returns list of [ContractVersion] objects
  Future<List<ContractVersion>> getcontract_versions({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/contract_version', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => ContractVersion.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch contract_versions',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new ContractVersion
  /// Returns created [ContractVersion] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
