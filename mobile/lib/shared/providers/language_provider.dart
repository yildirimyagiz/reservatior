import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/language_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Language Providers

final LanguageServiceProvider = Provider<LanguageService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LanguageService(dioClient);
});

// List Provider
final languageProvider = FutureProvider.autoDispose<List<Language>>((ref) async {
  final service = ref.watch(LanguageServiceProvider);
  return service.getLanguages();
});

// Create Provider
final LanguageCreateProvider = FutureProvider.autoDispose<Language>((ref) async {
  final service = ref.watch(LanguageServiceProvider);
  return service.createLanguage(Language());
});

// Update Provider  
final LanguageUpdateProvider = FutureProvider.autoDispose<Language>((ref) async {
  final service = ref.watch(LanguageServiceProvider);
  final state = ref.watch(LanguageUpdateStateProvider);
  if (state['id'] != null && state['language'] != null) {
    return service.updateLanguage(state['id'], state['language']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final LanguageDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(LanguageServiceProvider);
  final state = ref.watch(LanguageDeleteStateProvider);
  if (state != null) {
    return service.deleteLanguage(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final LanguageUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final LanguageDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final LanguageLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(languageProvider);
  final createAsync = ref.watch(LanguageCreateProvider);
  final updateAsync = ref.watch(LanguageUpdateProvider);
  final deleteAsync = ref.watch(LanguageDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
