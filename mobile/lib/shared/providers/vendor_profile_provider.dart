import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/vendor_profile_service.dart';
import 'package:reservatior/shared/repositories/vendor_profile_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final vendorProfileServiceProvider = Provider<VendorProfileService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VendorProfileService(dioClient);
});

final vendorProfileRepositoryProvider = Provider<VendorProfileRepository>((ref) {
  final service = ref.watch(vendorProfileServiceProvider);
  return VendorProfileRepositoryImpl(service);
});

final vendorProfileListProvider = FutureProvider.autoDispose<List<VendorProfile>>((ref) async {
  final repository = ref.watch(vendorProfileRepositoryProvider);
  return repository.getAll();
});

final vendorProfileCreateProvider = StateProvider<VendorProfile?>((ref) => null);
final vendorProfileUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final vendorProfileDeleteProvider = StateProvider<String?>((ref) => null);
final vendorProfileLoadingProvider = StateProvider<bool>((ref) => false);
