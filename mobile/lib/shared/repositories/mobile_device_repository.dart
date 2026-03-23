import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for MobileDevice operations
/// Provides CRUD operations with proper error handling and type safety
class MobileDeviceRepository {
  final DioClient _dioClient;

  MobileDeviceRepository(this._dioClient);

  /// Get MobileDevice by ID
  /// Returns [MobileDevice] if found, throws [RepositoryException] otherwise
  Future<MobileDevice> getMobileDeviceById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/mobile_device/$id');
      if (response.statusCode == 200) {
        return MobileDevice.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch mobile_device',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all mobile_devices with pagination and filtering
  /// Returns list of [MobileDevice] objects
  Future<List<MobileDevice>> getmobile_devices({
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
      
      final response = await _dioClient.get('/api/v1/mobile_device', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => MobileDevice.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch mobile_devices',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new MobileDevice
  /// Returns created [MobileDevice] object
  Future<MobileDevice> createMobileDevice(MobileDevice mobileDevice) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/mobile_device',
        data: mobileDevice.toJson(),
      );
      return MobileDevice.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MobileDevice
  Future<MobileDevice> updateMobileDevice(String id, MobileDevice mobileDevice) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/mobile_device/$id',
        data: mobileDevice.toJson(),
      );
      return MobileDevice.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MobileDevice
  Future<void> deleteMobileDevice(String id) async {
    try {
      await _dioClient.delete('/api/v1/mobile_device/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
