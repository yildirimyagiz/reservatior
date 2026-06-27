import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/guest_service.dart';
import 'package:reservatior/shared/repositories/guest_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final guestServiceProvider = Provider<GuestService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return GuestService(dioClient);
});

final guestRepositoryProvider = Provider<GuestRepository>((ref) {
  final service = ref.watch(guestServiceProvider);
  return GuestRepositoryImpl(service);
});

final guestListProvider = FutureProvider.autoDispose<List<Guest>>((ref) async {
  final repository = ref.watch(guestRepositoryProvider);
  return repository.getAll();
});

final guestCreateProvider = StateProvider<Guest?>((ref) => null);
final guestUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final guestDeleteProvider = StateProvider<String?>((ref) => null);
final guestLoadingProvider = StateProvider<bool>((ref) => false);
