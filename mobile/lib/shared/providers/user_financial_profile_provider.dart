import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/user_financial_profile_service.dart';
import 'package:reservatior/shared/repositories/user_financial_profile_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final userFinancialProfileServiceProvider = Provider<UserFinancialProfileService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UserFinancialProfileService(dioClient);
});

final userFinancialProfileRepositoryProvider = Provider<UserFinancialProfileRepository>((ref) {
  final service = ref.watch(userFinancialProfileServiceProvider);
  return UserFinancialProfileRepositoryImpl(service);
});

final userFinancialProfileListProvider = FutureProvider.autoDispose<List<UserFinancialProfile>>((ref) async {
  final repository = ref.watch(userFinancialProfileRepositoryProvider);
  return repository.getAll();
});

final userFinancialProfileCreateProvider = StateProvider<UserFinancialProfile?>((ref) => null);
final userFinancialProfileUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final userFinancialProfileDeleteProvider = StateProvider<String?>((ref) => null);
final userFinancialProfileLoadingProvider = StateProvider<bool>((ref) => false);
