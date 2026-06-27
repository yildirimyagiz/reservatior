import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/api_token_service.dart';
import 'package:reservatior/shared/repositories/api_token_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final apiTokenServiceProvider = Provider<ApiTokenService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ApiTokenService(dioClient);
});

final apiTokenRepositoryProvider = Provider<ApiTokenRepository>((ref) {
  final service = ref.watch(apiTokenServiceProvider);
  return ApiTokenRepositoryImpl(service);
});

final apiTokenListProvider = FutureProvider.autoDispose<List<ApiToken>>((ref) async {
  final repository = ref.watch(apiTokenRepositoryProvider);
  return repository.getAll();
});

final apiTokenCreateProvider = StateProvider<ApiToken?>((ref) => null);
final apiTokenUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final apiTokenDeleteProvider = StateProvider<String?>((ref) => null);
final apiTokenLoadingProvider = StateProvider<bool>((ref) => false);
