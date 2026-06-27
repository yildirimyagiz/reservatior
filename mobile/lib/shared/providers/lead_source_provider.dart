import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/lead_source_service.dart';
import 'package:reservatior/shared/repositories/lead_source_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final leadSourceServiceProvider = Provider<LeadSourceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LeadSourceService(dioClient);
});

final leadSourceRepositoryProvider = Provider<LeadSourceRepository>((ref) {
  final service = ref.watch(leadSourceServiceProvider);
  return LeadSourceRepositoryImpl(service);
});

final leadSourceListProvider = FutureProvider.autoDispose<List<LeadSource>>((ref) async {
  final repository = ref.watch(leadSourceRepositoryProvider);
  return repository.getAll();
});

final leadSourceCreateProvider = StateProvider<LeadSource?>((ref) => null);
final leadSourceUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final leadSourceDeleteProvider = StateProvider<String?>((ref) => null);
final leadSourceLoadingProvider = StateProvider<bool>((ref) => false);
