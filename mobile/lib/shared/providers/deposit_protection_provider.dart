import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/deposit_protection_service.dart';
import 'package:reservatior/shared/repositories/deposit_protection_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final depositProtectionServiceProvider = Provider<DepositProtectionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DepositProtectionService(dioClient);
});

final depositProtectionRepositoryProvider = Provider<DepositProtectionRepository>((ref) {
  final service = ref.watch(depositProtectionServiceProvider);
  return DepositProtectionRepositoryImpl(service);
});

final depositProtectionListProvider = FutureProvider.autoDispose<List<DepositProtection>>((ref) async {
  final repository = ref.watch(depositProtectionRepositoryProvider);
  return repository.getAll();
});

final depositProtectionCreateProvider = StateProvider<DepositProtection?>((ref) => null);
final depositProtectionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final depositProtectionDeleteProvider = StateProvider<String?>((ref) => null);
final depositProtectionLoadingProvider = StateProvider<bool>((ref) => false);
