import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class RentalSyncJobService {
  final DioClient _dioClient;
  RentalSyncJobService(this._dioClient);

  Future<RentalSyncJob> getRentalSyncJobById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.rentalSyncJobs}/$id');
    return RentalSyncJob.fromJson(response.data['data']);
  }

  Future<List<RentalSyncJob>> getRentalSyncJobs({
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
    final response = await _dioClient.get(ApiEndpoints.rentalSyncJobs, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => RentalSyncJob.fromJson(json)).toList();
  }

  Future<RentalSyncJob> createRentalSyncJob(RentalSyncJob item) async {
    final response = await _dioClient.post(ApiEndpoints.rentalSyncJobs, data: item.toJson());
    return RentalSyncJob.fromJson(response.data['data']);
  }

  Future<RentalSyncJob> updateRentalSyncJob(String id, RentalSyncJob item) async {
    final response = await _dioClient.patch('${ApiEndpoints.rentalSyncJobs}/$id', data: item.toJson());
    return RentalSyncJob.fromJson(response.data['data']);
  }

  Future<void> deleteRentalSyncJob(String id) async {
    await _dioClient.delete('${ApiEndpoints.rentalSyncJobs}/$id');
  }
}
