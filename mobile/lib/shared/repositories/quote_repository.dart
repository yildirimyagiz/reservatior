import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Quote operations
/// Provides CRUD operations with proper error handling and type safety
class QuoteRepository {
  final DioClient _dioClient;

  QuoteRepository(this._dioClient);

  /// Get Quote by ID
  /// Returns [Quote] if found, throws [RepositoryException] otherwise
  Future<Quote> getQuoteById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/quote/$id');
      if (response.statusCode == 200) {
        return Quote.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch quote',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all quotes with pagination and filtering
  /// Returns list of [Quote] objects
  Future<List<Quote>> getquotes({
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
      
      final response = await _dioClient.get('/api/v1/quote', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Quote.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch quotes',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Quote
  /// Returns created [Quote] object
  Future<Quote> createQuote(Quote quote) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/quote',
        data: quote.toJson(),
      );
      return Quote.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Quote
  Future<Quote> updateQuote(String id, Quote quote) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/quote/$id',
        data: quote.toJson(),
      );
      return Quote.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Quote
  Future<void> deleteQuote(String id) async {
    try {
      await _dioClient.delete('/api/v1/quote/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
