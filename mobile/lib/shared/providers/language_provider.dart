import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/language_service.dart';
import 'package:reservatior/shared/repositories/language_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final languageServiceProvider = Provider<LanguageService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LanguageService(dioClient);
});

final languageRepositoryProvider = Provider<LanguageRepository>((ref) {
  final service = ref.watch(languageServiceProvider);
  return LanguageRepositoryImpl(service);
});

final languageListProvider = FutureProvider.autoDispose<List<Language>>((ref) async {
  final repository = ref.watch(languageRepositoryProvider);
  return repository.getAll();
});

final languageCreateProvider = StateProvider<Language?>((ref) => null);
final languageUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final languageDeleteProvider = StateProvider<String?>((ref) => null);
final languageLoadingProvider = StateProvider<bool>((ref) => false);
