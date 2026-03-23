import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class VendorProfileService {
  final DioClient _dioClient;

  VendorProfileService(this._dioClient);

  // Get VendorProfile by ID
  Future<VendorProfile> getVendorProfileById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/vendor_profile/$id');
      return VendorProfile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all vendor_profiles
  Future<List<VendorProfile>> getVendorProfiles({
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

      final response = await _dioClient.get('/api/v1/vendor_profile', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => VendorProfile.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create VendorProfile
  Future<VendorProfile> createVendorProfile(VendorProfile vendorProfile) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/vendor_profile',
        data: vendorProfile.toJson(),
      );
      return VendorProfile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update VendorProfile
  Future<VendorProfile> updateVendorProfile(String id, VendorProfile vendorProfile) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/vendor_profile/$id',
        data: vendorProfile.toJson(),
      );
      return VendorProfile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete VendorProfile
  Future<void> deleteVendorProfile(String id) async {
    try {
      await _dioClient.delete('/api/v1/vendor_profile/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
