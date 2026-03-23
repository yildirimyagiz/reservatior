import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/document_analysis_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// DocumentAnalysis Providers

final DocumentAnalysisServiceProvider = Provider<DocumentAnalysisService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DocumentAnalysisService(dioClient);
});

// List Provider
final documentAnalysisProvider = FutureProvider.autoDispose<List<DocumentAnalysis>>((ref) async {
  final service = ref.watch(DocumentAnalysisServiceProvider);
  return service.getDocumentAnalysiss();
});

// Create Provider
final DocumentAnalysisCreateProvider = FutureProvider.autoDispose<DocumentAnalysis>((ref) async {
  final service = ref.watch(DocumentAnalysisServiceProvider);
  return service.createDocumentAnalysis(DocumentAnalysis());
});

// Update Provider  
final DocumentAnalysisUpdateProvider = FutureProvider.autoDispose<DocumentAnalysis>((ref) async {
  final service = ref.watch(DocumentAnalysisServiceProvider);
  final state = ref.watch(DocumentAnalysisUpdateStateProvider);
  if (state['id'] != null && state['document_analysis'] != null) {
    return service.updateDocumentAnalysis(state['id'], state['document_analysis']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final DocumentAnalysisDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(DocumentAnalysisServiceProvider);
  final state = ref.watch(DocumentAnalysisDeleteStateProvider);
  if (state != null) {
    return service.deleteDocumentAnalysis(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final DocumentAnalysisUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final DocumentAnalysisDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final DocumentAnalysisLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(documentAnalysisProvider);
  final createAsync = ref.watch(DocumentAnalysisCreateProvider);
  final updateAsync = ref.watch(DocumentAnalysisUpdateProvider);
  final deleteAsync = ref.watch(DocumentAnalysisDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
