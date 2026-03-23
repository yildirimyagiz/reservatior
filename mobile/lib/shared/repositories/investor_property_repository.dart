import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for InvestorProperty operations
/// Provides CRUD operations with proper error handling and type safety
class InvestorPropertyRepository {
  final DioClient _dioClient;

  InvestorPropertyRepository(this._dioClient);

  /// Get InvestorProperty by ID
  /// Returns [InvestorProperty] if found, throws [RepositoryException] otherwise
  Future<InvestorProperty> getInvestorPropertyById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/investor_property/$id');
      if (response.statusCode == 200) {
        return InvestorProperty.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch investor_property',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all investor_properties with pagination and filtering
  /// Returns list of [InvestorProperty] objects
  Future<List<InvestorProperty>> getinvestor_properties({
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
      
      final response = await _dioClient.get('/api/v1/investor_property', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => InvestorProperty.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch investor_properties',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new InvestorProperty
  /// Returns created [InvestorProperty] object
  Future<InvestorProperty> createInvestorProperty(InvestorProperty investorProperty) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/investor_property',
        data: investorProperty.toJson(),
      );
      return InvestorProperty.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update InvestorProperty
  Future<InvestorProperty> updateInvestorProperty(String id, InvestorProperty investorProperty) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/investor_property/$id',
        data: investorProperty.toJson(),
      );
      return InvestorProperty.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete InvestorProperty
  Future<void> deleteInvestorProperty(String id) async {
    try {
      await _dioClient.delete('/api/v1/investor_property/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
