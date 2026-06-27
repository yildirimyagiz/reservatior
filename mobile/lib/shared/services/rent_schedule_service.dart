import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class RentScheduleService {
  final DioClient _dioClient;
  RentScheduleService(this._dioClient);

  Future<RentSchedule> getRentScheduleById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.rentSchedules}/$id');
    return RentSchedule.fromJson(response.data['data']);
  }

  Future<List<RentSchedule>> getRentSchedules({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.rentSchedules, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => RentSchedule.fromJson(json)).toList();
  }

  Future<RentSchedule> createRentSchedule(RentSchedule item) async {
    final response = await _dioClient.post(ApiEndpoints.rentSchedules, data: item.toJson());
    return RentSchedule.fromJson(response.data['data']);
  }

  Future<RentSchedule> updateRentSchedule(String id, RentSchedule item) async {
    final response = await _dioClient.patch('${ApiEndpoints.rentSchedules}/$id', data: item.toJson());
    return RentSchedule.fromJson(response.data['data']);
  }

  Future<void> deleteRentSchedule(String id) async {
    await _dioClient.delete('${ApiEndpoints.rentSchedules}/$id');
  }
}
