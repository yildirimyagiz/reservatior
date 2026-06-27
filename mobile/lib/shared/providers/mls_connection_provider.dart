import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/mls_connection_service.dart';
import 'package:reservatior/shared/repositories/mls_connection_repository.dart';
import 'dio_client_provider.dart';
import 'package:reservatior/shared/models/models.dart';

final mlsConnectionServiceProvider = Provider<MlsConnectionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MlsConnectionService(dioClient);
});

final mlsConnectionRepositoryProvider = Provider<MlsConnectionRepository>((ref) {
  final service = ref.watch(mlsConnectionServiceProvider);
  return MlsConnectionRepositoryImpl(service);
});

final mlsConnectionListProvider = FutureProvider.autoDispose<List<MlsConnection>>((ref) async {
  final repository = ref.watch(mlsConnectionRepositoryProvider);
  return repository.getAll();
});

final mlsConnectionCreateProvider = StateProvider<MlsConnection?>((ref) => null);
final mlsConnectionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mlsConnectionDeleteProvider = StateProvider<String?>((ref) => null);
final mlsConnectionLoadingProvider = StateProvider<bool>((ref) => false);
