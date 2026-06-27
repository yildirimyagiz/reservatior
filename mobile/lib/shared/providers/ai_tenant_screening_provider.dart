import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_tenant_screening_service.dart';
import 'package:reservatior/shared/repositories/ai_tenant_screening_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiTenantScreeningServiceProvider = Provider<AiTenantScreeningService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiTenantScreeningService(dioClient);
});

final aiTenantScreeningRepositoryProvider = Provider<AiTenantScreeningRepository>((ref) {
  final service = ref.watch(aiTenantScreeningServiceProvider);
  return AiTenantScreeningRepositoryImpl(service);
});

final aiTenantScreeningListProvider = FutureProvider.autoDispose<List<AiTenantScreening>>((ref) async {
  final repository = ref.watch(aiTenantScreeningRepositoryProvider);
  return repository.getAll();
});

final aiTenantScreeningCreateProvider = StateProvider<AiTenantScreening?>((ref) => null);
final aiTenantScreeningUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiTenantScreeningDeleteProvider = StateProvider<String?>((ref) => null);
final aiTenantScreeningLoadingProvider = StateProvider<bool>((ref) => false);
