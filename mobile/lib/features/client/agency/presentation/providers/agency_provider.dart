import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/features/client/agency/data/models/agency_model.dart';
import 'package:reservatior/features/client/agency/data/services/agency_service.dart';

final agencyServiceProvider = Provider((ref) {
  return AgencyService(DioClient());
});

final agencyProvider = StateNotifierProvider<AgencyNotifier, AsyncValue<List<AgencyModel>>>((ref) {
  return AgencyNotifier(ref.watch(agencyServiceProvider));
});

class AgencyNotifier extends StateNotifier<AsyncValue<List<AgencyModel>>> {
  final AgencyService _service;

  AgencyNotifier(this._service) : super(const AsyncValue.loading()) {
    fetchAgencies();
  }

  Future<void> fetchAgencies() async {
    state = const AsyncValue.loading();
    try {
      final agencies = await _service.getAgencies();
      state = AsyncValue.data(agencies);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createAgency(String name, String email, String phoneNumber) async {
    try {
      await _service.createAgency(name, email, phoneNumber);
      await fetchAgencies();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAgency(String id) async {
    try {
      await _service.deleteAgency(id);
      await fetchAgencies();
    } catch (e) {
      rethrow;
    }
  }
}
