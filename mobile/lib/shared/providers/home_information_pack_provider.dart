import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/home_information_pack_service.dart';
import 'package:reservatior/shared/repositories/home_information_pack_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final homeInformationPackServiceProvider = Provider<HomeInformationPackService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return HomeInformationPackService(dioClient);
});

final homeInformationPackRepositoryProvider = Provider<HomeInformationPackRepository>((ref) {
  final service = ref.watch(homeInformationPackServiceProvider);
  return HomeInformationPackRepositoryImpl(service);
});

final homeInformationPackListProvider = FutureProvider.autoDispose<List<HomeInformationPack>>((ref) async {
  final repository = ref.watch(homeInformationPackRepositoryProvider);
  return repository.getAll();
});

final homeInformationPackCreateProvider = StateProvider<HomeInformationPack?>((ref) => null);
final homeInformationPackUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final homeInformationPackDeleteProvider = StateProvider<String?>((ref) => null);
final homeInformationPackLoadingProvider = StateProvider<bool>((ref) => false);
