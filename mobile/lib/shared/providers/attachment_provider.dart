import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/attachment_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Attachment Providers

final attachmentServiceProvider = Provider<AttachmentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AttachmentService(dioClient);
});

// List Provider
final attachmentListProvider = FutureProvider.autoDispose<List<Attachment>>((ref) async {
  final service = ref.watch(attachmentServiceProvider);
  return service.getAttachments();
});

// Create Provider
final attachmentCreateProvider = FutureProvider.autoDispose<Attachment>((ref) async {
  final service = ref.watch(attachmentServiceProvider);
  return service.createAttachment(Attachment());
});

// Update Provider  
final attachmentUpdateProvider = FutureProvider.autoDispose<Attachment>((ref) async {
  final service = ref.watch(attachmentServiceProvider);
  final state = ref.watch(attachmentUpdateStateProvider);
  if (state['id'] != null && state['attachment'] != null) {
    return service.updateAttachment(state['id'], state['attachment']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final attachmentDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(attachmentServiceProvider);
  final state = ref.watch(attachmentDeleteStateProvider);
  if (state != null) {
    return service.deleteAttachment(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final attachmentCreateStateProvider = StateProvider<Attachment?>((ref) => null);
final attachmentUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final attachmentDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final attachmentLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(attachmentListProvider);
  final createAsync = ref.watch(attachmentCreateProvider);
  final updateAsync = ref.watch(attachmentUpdateProvider);
  final deleteAsync = ref.watch(attachmentDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
