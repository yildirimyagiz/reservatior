import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MobileDeviceService {
  final DioClient _dioClient;

  MobileDeviceService(this._dioClient);

  // Get MobileDevice by ID
  Future<MobileDevice> getMobileDeviceById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/mobile_device/$id');
      return MobileDevice.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all mobile_devices
  Future<List<MobileDevice>> getMobileDevices({
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

      final response = await _dioClient.get('/api/v1/mobile_device', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MobileDevice.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MobileDevice
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
    return Exception('API Error: ${e.message}');
  }
}
