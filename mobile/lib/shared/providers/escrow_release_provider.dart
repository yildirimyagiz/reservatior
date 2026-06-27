import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/escrow_release_service.dart';
import 'package:reservatior/shared/repositories/escrow_release_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final escrowReleaseServiceProvider = Provider<EscrowReleaseService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EscrowReleaseService(dioClient);
});

final escrowReleaseRepositoryProvider = Provider<EscrowReleaseRepository>((ref) {
  final service = ref.watch(escrowReleaseServiceProvider);
  return EscrowReleaseRepositoryImpl(service);
});

final escrowReleaseListProvider = FutureProvider.autoDispose<List<EscrowRelease>>((ref) async {
  final repository = ref.watch(escrowReleaseRepositoryProvider);
  return repository.getAll();
});

final escrowReleaseCreateProvider = StateProvider<EscrowRelease?>((ref) => null);
final escrowReleaseUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final escrowReleaseDeleteProvider = StateProvider<String?>((ref) => null);
final escrowReleaseLoadingProvider = StateProvider<bool>((ref) => false);
