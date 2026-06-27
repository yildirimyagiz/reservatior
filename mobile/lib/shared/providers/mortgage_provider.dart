import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/mortgage_service.dart';
import 'package:reservatior/shared/repositories/mortgage_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final mortgageServiceProvider = Provider<MortgageService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MortgageService(dioClient);
});

final mortgageRepositoryProvider = Provider<MortgageRepository>((ref) {
  final service = ref.watch(mortgageServiceProvider);
  return MortgageRepositoryImpl(service);
});

final mortgageListProvider = FutureProvider.autoDispose<List<Mortgage>>((ref) async {
  final repository = ref.watch(mortgageRepositoryProvider);
  return repository.getAll();
});

final mortgageCreateProvider = StateProvider<Mortgage?>((ref) => null);
final mortgageUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mortgageDeleteProvider = StateProvider<String?>((ref) => null);
final mortgageLoadingProvider = StateProvider<bool>((ref) => false);
