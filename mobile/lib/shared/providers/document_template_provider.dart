import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/document_template_service.dart';
import 'package:reservatior/shared/repositories/document_template_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final documentTemplateServiceProvider = Provider<DocumentTemplateService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DocumentTemplateService(dioClient);
});

final documentTemplateRepositoryProvider = Provider<DocumentTemplateRepository>((ref) {
  final service = ref.watch(documentTemplateServiceProvider);
  return DocumentTemplateRepositoryImpl(service);
});

final documentTemplateListProvider = FutureProvider.autoDispose<List<DocumentTemplate>>((ref) async {
  final repository = ref.watch(documentTemplateRepositoryProvider);
  return repository.getAll();
});

final documentTemplateCreateProvider = StateProvider<DocumentTemplate?>((ref) => null);
final documentTemplateUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final documentTemplateDeleteProvider = StateProvider<String?>((ref) => null);
final documentTemplateLoadingProvider = StateProvider<bool>((ref) => false);
