import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/virtual_tour_service.dart';
import 'package:reservatior/shared/repositories/virtual_tour_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final virtualTourServiceProvider = Provider<VirtualTourService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return VirtualTourService(dioClient);
});

final virtualTourRepositoryProvider = Provider<VirtualTourRepository>((ref) {
  final service = ref.watch(virtualTourServiceProvider);
  return VirtualTourRepositoryImpl(service);
});

final virtualTourListProvider = FutureProvider.autoDispose<List<VirtualTour>>((ref) async {
  final repository = ref.watch(virtualTourRepositoryProvider);
  return repository.getAll();
});

final virtualTourCreateProvider = StateProvider<VirtualTour?>((ref) => null);
final virtualTourUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final virtualTourDeleteProvider = StateProvider<String?>((ref) => null);
final virtualTourLoadingProvider = StateProvider<bool>((ref) => false);
