import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/investor_property_service.dart';
import 'package:reservatior/shared/repositories/investor_property_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final investorPropertyServiceProvider = Provider<InvestorPropertyService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return InvestorPropertyService(dioClient);
});

final investorPropertyRepositoryProvider = Provider<InvestorPropertyRepository>((ref) {
  final service = ref.watch(investorPropertyServiceProvider);
  return InvestorPropertyRepositoryImpl(service);
});

final investorPropertyListProvider = FutureProvider.autoDispose<List<InvestorProperty>>((ref) async {
  final repository = ref.watch(investorPropertyRepositoryProvider);
  return repository.getAll();
});

final investorPropertyCreateProvider = StateProvider<InvestorProperty?>((ref) => null);
final investorPropertyUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final investorPropertyDeleteProvider = StateProvider<String?>((ref) => null);
final investorPropertyLoadingProvider = StateProvider<bool>((ref) => false);
