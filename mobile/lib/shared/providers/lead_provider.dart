import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/lead_service.dart';
import 'package:reservatior/shared/repositories/lead_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final leadServiceProvider = Provider<LeadService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LeadService(dioClient);
});

final leadRepositoryProvider = Provider<LeadRepository>((ref) {
  final service = ref.watch(leadServiceProvider);
  return LeadRepositoryImpl(service);
});

final leadListProvider = FutureProvider.autoDispose<List<Lead>>((ref) async {
  final repository = ref.watch(leadRepositoryProvider);
  return repository.getAll();
});

final leadCreateProvider = StateProvider<Lead?>((ref) => null);
final leadUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final leadDeleteProvider = StateProvider<String?>((ref) => null);
final leadLoadingProvider = StateProvider<bool>((ref) => false);
