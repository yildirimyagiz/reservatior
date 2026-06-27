import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/security_deposit_protection_service.dart';
import 'package:reservatior/shared/repositories/security_deposit_protection_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final securityDepositProtectionServiceProvider = Provider<SecurityDepositProtectionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SecurityDepositProtectionService(dioClient);
});

final securityDepositProtectionRepositoryProvider = Provider<SecurityDepositProtectionRepository>((ref) {
  final service = ref.watch(securityDepositProtectionServiceProvider);
  return SecurityDepositProtectionRepositoryImpl(service);
});

final securityDepositProtectionListProvider = FutureProvider.autoDispose<List<SecurityDepositProtection>>((ref) async {
  final repository = ref.watch(securityDepositProtectionRepositoryProvider);
  return repository.getAll();
});

final securityDepositProtectionCreateProvider = StateProvider<SecurityDepositProtection?>((ref) => null);
final securityDepositProtectionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final securityDepositProtectionDeleteProvider = StateProvider<String?>((ref) => null);
final securityDepositProtectionLoadingProvider = StateProvider<bool>((ref) => false);
