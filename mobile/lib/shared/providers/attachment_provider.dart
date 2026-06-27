import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/attachment_service.dart';
import 'package:reservatior/shared/repositories/attachment_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final attachmentServiceProvider = Provider<AttachmentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AttachmentService(dioClient);
});

final attachmentRepositoryProvider = Provider<AttachmentRepository>((ref) {
  final service = ref.watch(attachmentServiceProvider);
  return AttachmentRepositoryImpl(service);
});

final attachmentListProvider = FutureProvider.autoDispose<List<Attachment>>((ref) async {
  final repository = ref.watch(attachmentRepositoryProvider);
  return repository.getAll();
});

final attachmentCreateProvider = StateProvider<Attachment?>((ref) => null);
final attachmentUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final attachmentDeleteProvider = StateProvider<String?>((ref) => null);
final attachmentLoadingProvider = StateProvider<bool>((ref) => false);
