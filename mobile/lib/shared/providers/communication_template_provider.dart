import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/communication_template_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// CommunicationTemplate Providers

final CommunicationTemplateServiceProvider = Provider<CommunicationTemplateService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CommunicationTemplateService(dioClient);
});

// List Provider
final communicationTemplateProvider = FutureProvider.autoDispose<List<CommunicationTemplate>>((ref) async {
  final service = ref.watch(CommunicationTemplateServiceProvider);
  return service.getCommunicationTemplates();
});

// Create Provider
final CommunicationTemplateCreateProvider = FutureProvider.autoDispose<CommunicationTemplate>((ref) async {
  final service = ref.watch(CommunicationTemplateServiceProvider);
  return service.createCommunicationTemplate(CommunicationTemplate());
});

// Update Provider  
final CommunicationTemplateUpdateProvider = FutureProvider.autoDispose<CommunicationTemplate>((ref) async {
  final service = ref.watch(CommunicationTemplateServiceProvider);
  final state = ref.watch(CommunicationTemplateUpdateStateProvider);
  if (state['id'] != null && state['communication_template'] != null) {
    return service.updateCommunicationTemplate(state['id'], state['communication_template']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final CommunicationTemplateDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(CommunicationTemplateServiceProvider);
  final state = ref.watch(CommunicationTemplateDeleteStateProvider);
  if (state != null) {
    return service.deleteCommunicationTemplate(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final CommunicationTemplateUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final CommunicationTemplateDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final CommunicationTemplateLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(communicationTemplateProvider);
  final createAsync = ref.watch(CommunicationTemplateCreateProvider);
  final updateAsync = ref.watch(CommunicationTemplateUpdateProvider);
  final deleteAsync = ref.watch(CommunicationTemplateDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
