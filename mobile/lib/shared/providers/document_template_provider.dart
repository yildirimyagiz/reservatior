import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/document_template_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// DocumentTemplate Providers

final DocumentTemplateServiceProvider = Provider<DocumentTemplateService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DocumentTemplateService(dioClient);
});

// List Provider
final documentTemplateProvider = FutureProvider.autoDispose<List<DocumentTemplate>>((ref) async {
  final service = ref.watch(DocumentTemplateServiceProvider);
  return service.getDocumentTemplates();
});

// Create Provider
final DocumentTemplateCreateProvider = FutureProvider.autoDispose<DocumentTemplate>((ref) async {
  final service = ref.watch(DocumentTemplateServiceProvider);
  return service.createDocumentTemplate(DocumentTemplate());
});

// Update Provider  
final DocumentTemplateUpdateProvider = FutureProvider.autoDispose<DocumentTemplate>((ref) async {
  final service = ref.watch(DocumentTemplateServiceProvider);
  final state = ref.watch(DocumentTemplateUpdateStateProvider);
  if (state['id'] != null && state['document_template'] != null) {
    return service.updateDocumentTemplate(state['id'], state['document_template']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final DocumentTemplateDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(DocumentTemplateServiceProvider);
  final state = ref.watch(DocumentTemplateDeleteStateProvider);
  if (state != null) {
    return service.deleteDocumentTemplate(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final DocumentTemplateUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final DocumentTemplateDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final DocumentTemplateLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(documentTemplateProvider);
  final createAsync = ref.watch(DocumentTemplateCreateProvider);
  final updateAsync = ref.watch(DocumentTemplateUpdateProvider);
  final deleteAsync = ref.watch(DocumentTemplateDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
