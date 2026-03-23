import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for InvestorPortfolio operations
/// Provides CRUD operations with proper error handling and type safety
class InvestorPortfolioRepository {
  final DioClient _dioClient;

  InvestorPortfolioRepository(this._dioClient);

  /// Get InvestorPortfolio by ID
  /// Returns [InvestorPortfolio] if found, throws [RepositoryException] otherwise
  Future<InvestorPortfolio> getInvestorPortfolioById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/investor_portfolio/$id');
      if (response.statusCode == 200) {
        return InvestorPortfolio.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch investor_portfolio',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all investor_portfolios with pagination and filtering
  /// Returns list of [InvestorPortfolio] objects
  Future<List<InvestorPortfolio>> getinvestor_portfolios({
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
      
      final response = await _dioClient.get('/api/v1/investor_portfolio', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => InvestorPortfolio.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch investor_portfolios',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new InvestorPortfolio
  /// Returns created [InvestorPortfolio] object
  Future<InvestorPortfolio> createInvestorPortfolio(InvestorPortfolio investorPortfolio) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/investor_portfolio',
        data: investorPortfolio.toJson(),
      );
      return InvestorPortfolio.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update InvestorPortfolio
  Future<InvestorPortfolio> updateInvestorPortfolio(String id, InvestorPortfolio investorPortfolio) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/investor_portfolio/$id',
        data: investorPortfolio.toJson(),
      );
      return InvestorPortfolio.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete InvestorPortfolio
  Future<void> deleteInvestorPortfolio(String id) async {
    try {
      await _dioClient.delete('/api/v1/investor_portfolio/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
