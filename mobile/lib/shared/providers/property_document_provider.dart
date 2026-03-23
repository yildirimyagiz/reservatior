import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/property_document_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PropertyDocument Providers

final PropertyDocumentServiceProvider = Provider<PropertyDocumentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyDocumentService(dioClient);
});

// List Provider
final propertyDocumentProvider = FutureProvider.autoDispose<List<PropertyDocument>>((ref) async {
  final service = ref.watch(PropertyDocumentServiceProvider);
  return service.getPropertyDocuments();
});

// Create Provider
final PropertyDocumentCreateProvider = FutureProvider.autoDispose<PropertyDocument>((ref) async {
  final service = ref.watch(PropertyDocumentServiceProvider);
  return service.createPropertyDocument(PropertyDocument());
});

// Update Provider  
final PropertyDocumentUpdateProvider = FutureProvider.autoDispose<PropertyDocument>((ref) async {
  final service = ref.watch(PropertyDocumentServiceProvider);
  final state = ref.watch(PropertyDocumentUpdateStateProvider);
  if (state['id'] != null && state['property_document'] != null) {
    return service.updatePropertyDocument(state['id'], state['property_document']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PropertyDocumentDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PropertyDocumentServiceProvider);
  final state = ref.watch(PropertyDocumentDeleteStateProvider);
  if (state != null) {
    return service.deletePropertyDocument(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PropertyDocumentUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PropertyDocumentDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PropertyDocumentLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(propertyDocumentProvider);
  final createAsync = ref.watch(PropertyDocumentCreateProvider);
  final updateAsync = ref.watch(PropertyDocumentUpdateProvider);
  final deleteAsync = ref.watch(PropertyDocumentDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
