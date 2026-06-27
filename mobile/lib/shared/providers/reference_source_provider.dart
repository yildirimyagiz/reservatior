import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/reference_source_service.dart';
import 'package:reservatior/shared/repositories/reference_source_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final referenceSourceServiceProvider = Provider<ReferenceSourceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReferenceSourceService(dioClient);
});

final referenceSourceRepositoryProvider = Provider<ReferenceSourceRepository>((ref) {
  final service = ref.watch(referenceSourceServiceProvider);
  return ReferenceSourceRepositoryImpl(service);
});

final referenceSourceListProvider = FutureProvider.autoDispose<List<ReferenceSource>>((ref) async {
  final repository = ref.watch(referenceSourceRepositoryProvider);
  return repository.getAll();
});

final referenceSourceCreateProvider = StateProvider<ReferenceSource?>((ref) => null);
final referenceSourceUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final referenceSourceDeleteProvider = StateProvider<String?>((ref) => null);
final referenceSourceLoadingProvider = StateProvider<bool>((ref) => false);
