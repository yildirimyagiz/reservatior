import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/guest_profile_service.dart';
import 'package:reservatior/shared/repositories/guest_profile_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final guestProfileServiceProvider = Provider<GuestProfileService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GuestProfileService(dioClient);
});

final guestProfileRepositoryProvider = Provider<GuestProfileRepository>((ref) {
  final service = ref.watch(guestProfileServiceProvider);
  return GuestProfileRepositoryImpl(service);
});

final guestProfileListProvider = FutureProvider.autoDispose<List<GuestProfile>>((ref) async {
  final repository = ref.watch(guestProfileRepositoryProvider);
  return repository.getAll();
});

final guestProfileCreateProvider = StateProvider<GuestProfile?>((ref) => null);
final guestProfileUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final guestProfileDeleteProvider = StateProvider<String?>((ref) => null);
final guestProfileLoadingProvider = StateProvider<bool>((ref) => false);
