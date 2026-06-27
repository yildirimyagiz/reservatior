import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/tax_depreciation_service.dart';
import 'package:reservatior/shared/repositories/tax_depreciation_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final taxDepreciationServiceProvider = Provider<TaxDepreciationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TaxDepreciationService(dioClient);
});

final taxDepreciationRepositoryProvider = Provider<TaxDepreciationRepository>((ref) {
  final service = ref.watch(taxDepreciationServiceProvider);
  return TaxDepreciationRepositoryImpl(service);
});

final taxDepreciationListProvider = FutureProvider.autoDispose<List<TaxDepreciation>>((ref) async {
  final repository = ref.watch(taxDepreciationRepositoryProvider);
  return repository.getAll();
});

final taxDepreciationCreateProvider = StateProvider<TaxDepreciation?>((ref) => null);
final taxDepreciationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final taxDepreciationDeleteProvider = StateProvider<String?>((ref) => null);
final taxDepreciationLoadingProvider = StateProvider<bool>((ref) => false);
