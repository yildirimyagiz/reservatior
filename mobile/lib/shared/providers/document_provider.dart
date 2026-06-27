import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/document_service.dart';
import 'package:reservatior/shared/repositories/document_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final documentServiceProvider = Provider<DocumentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DocumentService(dioClient);
});

final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  final service = ref.watch(documentServiceProvider);
  return DocumentRepositoryImpl(service);
});

final documentListProvider = FutureProvider.autoDispose<List<Document>>((ref) async {
  final repository = ref.watch(documentRepositoryProvider);
  return repository.getAll();
});

final documentCreateProvider = StateProvider<Document?>((ref) => null);
final documentUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final documentDeleteProvider = StateProvider<String?>((ref) => null);
final documentLoadingProvider = StateProvider<bool>((ref) => false);
