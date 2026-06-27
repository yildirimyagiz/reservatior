import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/features/client/facility/data/models/facility_model.dart';
import 'package:reservatior/features/client/facility/data/services/facility_service.dart';

final facilityServiceProvider = Provider((ref) {
  return FacilityService(DioClient());
});

final facilitiesProvider = StateNotifierProvider<FacilitiesNotifier, AsyncValue<List<FacilityModel>>>((ref) {
  return FacilitiesNotifier(ref.watch(facilityServiceProvider));
});

class FacilitiesNotifier extends StateNotifier<AsyncValue<List<FacilityModel>>> {
  final FacilityService _service;

  FacilitiesNotifier(this._service) : super(const AsyncValue.loading()) {
    fetchFacilities();
  }

  Future<void> fetchFacilities() async {
    state = const AsyncValue.loading();
    try {
      final facilities = await _service.getFacilities();
      state = AsyncValue.data(facilities);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createFacility(String name, double feeAmount, String feeCurrency) async {
    try {
      await _service.createFacility(name, feeAmount, feeCurrency);
      await fetchFacilities();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFacility(String id) async {
    try {
      await _service.deleteFacility(id);
      await fetchFacilities();
    } catch (e) {
      rethrow;
    }
  }
}
