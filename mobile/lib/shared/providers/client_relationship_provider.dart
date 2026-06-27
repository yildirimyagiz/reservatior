import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/client_relationship_service.dart';
import 'package:reservatior/shared/repositories/client_relationship_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final clientRelationshipServiceProvider = Provider<ClientRelationshipService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ClientRelationshipService(dioClient);
});

final clientRelationshipRepositoryProvider = Provider<ClientRelationshipRepository>((ref) {
  final service = ref.watch(clientRelationshipServiceProvider);
  return ClientRelationshipRepositoryImpl(service);
});

final clientRelationshipListProvider = FutureProvider.autoDispose<List<ClientRelationship>>((ref) async {
  final repository = ref.watch(clientRelationshipRepositoryProvider);
  return repository.getAll();
});

final clientRelationshipCreateProvider = StateProvider<ClientRelationship?>((ref) => null);
final clientRelationshipUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final clientRelationshipDeleteProvider = StateProvider<String?>((ref) => null);
final clientRelationshipLoadingProvider = StateProvider<bool>((ref) => false);
