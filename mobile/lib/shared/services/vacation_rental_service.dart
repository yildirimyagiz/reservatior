import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class VacationRentalService {
  final DioClient _dioClient;
  VacationRentalService(this._dioClient);

  Future<VacationRental> getVacationRentalById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.vacationRentals}/$id');
    return VacationRental.fromJson(response.data['data']);
  }

  Future<List<VacationRental>> getVacationRentals({
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
    final response = await _dioClient.get(ApiEndpoints.vacationRentals, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => VacationRental.fromJson(json)).toList();
  }

  Future<VacationRental> createVacationRental(VacationRental item) async {
    final response = await _dioClient.post(ApiEndpoints.vacationRentals, data: item.toJson());
    return VacationRental.fromJson(response.data['data']);
  }

  Future<VacationRental> updateVacationRental(String id, VacationRental item) async {
    final response = await _dioClient.patch('${ApiEndpoints.vacationRentals}/$id', data: item.toJson());
    return VacationRental.fromJson(response.data['data']);
  }

  Future<void> deleteVacationRental(String id) async {
    await _dioClient.delete('${ApiEndpoints.vacationRentals}/$id');
  }
}
