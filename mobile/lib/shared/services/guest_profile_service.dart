import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class GuestProfileService {
  final DioClient _dioClient;

  GuestProfileService(this._dioClient);

  // Get GuestProfile by ID
  Future<GuestProfile> getGuestProfileById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/guest_profile/$id');
      return GuestProfile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all guest_profiles
  Future<List<GuestProfile>> getGuestProfiles({
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

      final response = await _dioClient.get('/api/v1/guest_profile', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => GuestProfile.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create GuestProfile
  Future<GuestProfile> createGuestProfile(GuestProfile guestProfile) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/guest_profile',
        data: guestProfile.toJson(),
      );
      return GuestProfile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update GuestProfile
  Future<GuestProfile> updateGuestProfile(String id, GuestProfile guestProfile) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/guest_profile/$id',
        data: guestProfile.toJson(),
      );
      return GuestProfile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete GuestProfile
  Future<void> deleteGuestProfile(String id) async {
    try {
      await _dioClient.delete('/api/v1/guest_profile/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
