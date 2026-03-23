import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/shared/services/document_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Document Providers

final documentServiceProvider = Provider<DocumentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DocumentService(dioClient);
});

final documentListProvider = FutureProvider.autoDispose<List<Document>>((ref) async {
  final service = ref.watch(documentServiceProvider);
  return service.getAll();
});

final documentCreateProvider = FutureProvider.autoDispose<Document>((ref) async {
  final service = ref.watch(documentServiceProvider);
  final state = ref.watch(documentCreateStateProvider);
  if (state != null) {
    return service.create(state);
  }
  throw Exception('No create data provided');
});

final documentUpdateProvider = FutureProvider.autoDispose<Document>((ref) async {
  final service = ref.watch(documentServiceProvider);
  final state = ref.watch(documentUpdateStateProvider);
  if (state['id'] != null && state['data'] != null) {
    return service.update(state['id'], state['data']);
  }
  throw Exception('No update data provided');
});

final documentDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(documentServiceProvider);
  final state = ref.watch(documentDeleteStateProvider);
  if (state != null) {
    return service.delete(state);
  }
  throw Exception('No delete ID provided');
});

final documentCreateStateProvider = StateProvider<Document?>((ref) => null);
final documentUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final documentDeleteStateProvider = StateProvider<String?>((ref) => null);

final documentLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(documentListProvider);
  final createAsync = ref.watch(documentCreateProvider);
  final updateAsync = ref.watch(documentUpdateProvider);
  final deleteAsync = ref.watch(documentDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
