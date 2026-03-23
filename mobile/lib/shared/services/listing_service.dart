import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ListingService {
  final DioClient _dioClient;

  ListingService(this._dioClient);

  // Get Listing by ID
  Future<Listing> getListingById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/listing/$id');
      return Listing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all listings
  Future<List<Listing>> getListings({
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

      final response = await _dioClient.get('/api/v1/listing', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Listing.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Listing
  Future<Listing> createListing(Listing listing) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/listing',
        data: listing.toJson(),
      );
      return Listing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Listing
  Future<Listing> updateListing(String id, Listing listing) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/listing/$id',
        data: listing.toJson(),
      );
      return Listing.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Listing
  Future<void> deleteListing(String id) async {
    try {
      await _dioClient.delete('/api/v1/listing/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
