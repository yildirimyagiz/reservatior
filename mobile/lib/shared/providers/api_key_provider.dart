import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/api_key_service.dart';
import 'package:reservatior/shared/repositories/api_key_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final apiKeyServiceProvider = Provider<ApiKeyService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ApiKeyService(dioClient);
});

final apiKeyRepositoryProvider = Provider<ApiKeyRepository>((ref) {
  final service = ref.watch(apiKeyServiceProvider);
  return ApiKeyRepositoryImpl(service);
});

final apiKeyListProvider = FutureProvider.autoDispose<List<ApiKey>>((ref) async {
  final repository = ref.watch(apiKeyRepositoryProvider);
  return repository.getAll();
});

final apiKeyCreateProvider = StateProvider<ApiKey?>((ref) => null);
final apiKeyUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final apiKeyDeleteProvider = StateProvider<String?>((ref) => null);
final apiKeyLoadingProvider = StateProvider<bool>((ref) => false);
