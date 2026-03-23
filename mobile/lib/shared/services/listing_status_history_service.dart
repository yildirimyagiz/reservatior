import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ListingStatusHistoryService {
  final DioClient _dioClient;

  ListingStatusHistoryService(this._dioClient);

  // Get ListingStatusHistory by ID
  Future<ListingStatusHistory> getListingStatusHistoryById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/listing_status_history/$id');
      return ListingStatusHistory.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all listing_status_historys
  Future<List<ListingStatusHistory>> getListingStatusHistorys({
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

      final response = await _dioClient.get('/api/v1/listing_status_history', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ListingStatusHistory.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ListingStatusHistory
  Future<ListingStatusHistory> createListingStatusHistory(ListingStatusHistory listingStatusHistory) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/listing_status_history',
        data: listingStatusHistory.toJson(),
      );
      return ListingStatusHistory.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ListingStatusHistory
  Future<ListingStatusHistory> updateListingStatusHistory(String id, ListingStatusHistory listingStatusHistory) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/listing_status_history/$id',
        data: listingStatusHistory.toJson(),
      );
      return ListingStatusHistory.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ListingStatusHistory
  Future<void> deleteListingStatusHistory(String id) async {
    try {
      await _dioClient.delete('/api/v1/listing_status_history/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
