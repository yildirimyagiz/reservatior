import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for MortgageOffer operations
/// Provides CRUD operations with proper error handling and type safety
class MortgageOfferRepository {
  final DioClient _dioClient;

  MortgageOfferRepository(this._dioClient);

  /// Get MortgageOffer by ID
  /// Returns [MortgageOffer] if found, throws [RepositoryException] otherwise
  Future<MortgageOffer> getMortgageOfferById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/mortgage_offer/$id');
      if (response.statusCode == 200) {
        return MortgageOffer.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch mortgage_offer',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all mortgage_offers with pagination and filtering
  /// Returns list of [MortgageOffer] objects
  Future<List<MortgageOffer>> getmortgage_offers({
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
      
      final response = await _dioClient.get('/api/v1/mortgage_offer', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => MortgageOffer.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch mortgage_offers',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new MortgageOffer
  /// Returns created [MortgageOffer] object
  Future<MortgageOffer> createMortgageOffer(MortgageOffer mortgageOffer) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/mortgage_offer',
        data: mortgageOffer.toJson(),
      );
      return MortgageOffer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MortgageOffer
  Future<MortgageOffer> updateMortgageOffer(String id, MortgageOffer mortgageOffer) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/mortgage_offer/$id',
        data: mortgageOffer.toJson(),
      );
      return MortgageOffer.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MortgageOffer
  Future<void> deleteMortgageOffer(String id) async {
    try {
      await _dioClient.delete('/api/v1/mortgage_offer/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
