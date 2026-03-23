import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Contract operations
/// Provides CRUD operations with proper error handling and type safety
class ContractRepository {
  final DioClient _dioClient;

  ContractRepository(this._dioClient);

  /// Get Contract by ID
  /// Returns [Contract] if found, throws [RepositoryException] otherwise
  Future<Contract> getContractById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/contract/$id');
      if (response.statusCode == 200) {
        return Contract.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch contract',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all contracts with pagination and filtering
  /// Returns list of [Contract] objects
  Future<List<Contract>> getcontracts({
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
      
      final response = await _dioClient.get('/api/v1/contract', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Contract.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch contracts',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Contract
  /// Returns created [Contract] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
