import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/property_document_service.dart';
import 'package:reservatior/shared/repositories/property_document_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final propertyDocumentServiceProvider = Provider<PropertyDocumentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyDocumentService(dioClient);
});

final propertyDocumentRepositoryProvider = Provider<PropertyDocumentRepository>((ref) {
  final service = ref.watch(propertyDocumentServiceProvider);
  return PropertyDocumentRepositoryImpl(service);
});

final propertyDocumentListProvider = FutureProvider.autoDispose.family<List<PropertyDocument>, String>((ref, propertyId) async {
  final repository = ref.watch(propertyDocumentRepositoryProvider);
  return repository.getAll(filters: {'propertyId': propertyId});
});

final propertyDocumentCreateProvider = StateProvider<PropertyDocument?>((ref) => null);
final propertyDocumentUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final propertyDocumentDeleteProvider = StateProvider<String?>((ref) => null);
final propertyDocumentLoadingProvider = StateProvider<bool>((ref) => false);
