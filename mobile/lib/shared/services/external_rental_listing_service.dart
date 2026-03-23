import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ExternalRentalListingService {
  final DioClient _dioClient;

  ExternalRentalListingService(this._dioClient);

  // Get ExternalRentalListing by ID
  Future<ExternalRentalListing> getExternalRentalListingById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/external_rental_listing/$id');
      return ExternalRentalListing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all external_rental_listings
  Future<List<ExternalRentalListing>> getExternalRentalListings({
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

      final response = await _dioClient.get('/api/v1/external_rental_listing', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ExternalRentalListing.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ExternalRentalListing
  Future<ExternalRentalListing> createExternalRentalListing(ExternalRentalListing externalRentalListing) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/external_rental_listing',
        data: externalRentalListing.toJson(),
      );
      return ExternalRentalListing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ExternalRentalListing
  Future<ExternalRentalListing> updateExternalRentalListing(String id, ExternalRentalListing externalRentalListing) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/external_rental_listing/$id',
        data: externalRentalListing.toJson(),
      );
      return ExternalRentalListing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ExternalRentalListing
  Future<void> deleteExternalRentalListing(String id) async {
    try {
      await _dioClient.delete('/api/v1/external_rental_listing/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
