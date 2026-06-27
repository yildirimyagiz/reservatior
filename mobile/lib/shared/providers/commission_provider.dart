import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/commission_service.dart';
import 'package:reservatior/shared/repositories/commission_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final commissionServiceProvider = Provider<CommissionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CommissionService(dioClient);
});

final commissionRepositoryProvider = Provider<CommissionRepository>((ref) {
  final service = ref.watch(commissionServiceProvider);
  return CommissionRepositoryImpl(service);
});

final commissionListProvider = FutureProvider.autoDispose<List<Commission>>((ref) async {
  final repository = ref.watch(commissionRepositoryProvider);
  return repository.getAll();
});

final commissionCreateProvider = StateProvider<Commission?>((ref) => null);
final commissionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final commissionDeleteProvider = StateProvider<String?>((ref) => null);
final commissionLoadingProvider = StateProvider<bool>((ref) => false);
